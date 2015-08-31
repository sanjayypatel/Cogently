class Organization < ActiveRecord::Base
  has_many :memberships
  belongs_to :moderator, class_name: "User", foreign_key: "moderator_id"

  # Defining a users method rather than using the rails association to filter only
  # confirmed members of the organization. Replaced line:
  # has_many :users, through: :memberships
  def users
    User.joins(:membership).where("'memberships'.'confirmed' = ?", true).where("'memberships'.'organization_id' = #{id}").distinct
  end
end
