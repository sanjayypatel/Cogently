class Event < ActiveRecord::Base
  alias_attribute :sort_date, :start_time
  belongs_to :organization
  has_and_belongs_to_many :users
  has_and_belongs_to_many :summaries
  scope :starting_during, -> (time) { where("strftime('%m', start_time) = ?", time.strftime('%m')) }

  def attended_by?(user)
    return self.users.include?(user)
  end
end
