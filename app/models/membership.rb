class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  scope :are_confirmed, -> { where(confirmed: true) }
end
