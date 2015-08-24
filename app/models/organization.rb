class Organization < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :moderator, class_name: "User", foreign_key: "moderator_id"
end
