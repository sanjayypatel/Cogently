class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitees, class_name: "User", foreign_key: "invited_organization_id"
  belongs_to :moderator, class_name: "User", foreign_key: "moderator_id"
  has_many :documents
  has_many :summaries, :through => :documents
  has_many :events
  acts_as_tagger

  def search_for_invitable_users(query)
    members_and_invitees = self.users.to_a + self.invitees.to_a
    found_users = User.where("email like ?", "%#{query}%").to_a - members_and_invitees
    return found_users.select {|user| user.moderated_organization.nil?}
  end

  def search_members(query)
    self.users.where("email like ?", "%#{query}%").to_a
  end

  def search_summaries(query)
    self.summaries.joins(:document).where("documents.name like ?", "%#{query}%")
  end

  def search_documents(query)
    (self.documents.where("documents.name like ?", "%#{query}%") +
    self.documents.tagged_with("#{query}")).uniq
  end
end
