class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invitees, class_name: "User", foreign_key: "invited_organization_id"
  belongs_to :moderator, class_name: "User", foreign_key: "moderator_id"
  has_many :documents
  acts_as_tagger
  def search_for_invitable_users(query)
    members_and_invitees = self.users.to_a + self.invitees.to_a
    User.where("email like ?", "%#{query}%").to_a - members_and_invitees
  end
end
