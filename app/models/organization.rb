class Organization < ActiveRecord::Base
  has_many :users
  belongs_to :moderator, class_name: "User", foreign_key: "moderator_id"
end
