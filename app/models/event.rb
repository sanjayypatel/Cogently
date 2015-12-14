class Event < ActiveRecord::Base
  alias_attribute :sort_date, :start_time
  belongs_to :organization
  has_and_belongs_to_many :users
  has_and_belongs_to_many :summaries
  scope :starting_during, -> (time) { where(start_time: time.beginning_of_month..time.end_of_month) }

  def attended_by?(user)
    return self.users.include?(user)
  end
end
