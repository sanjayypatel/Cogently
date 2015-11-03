class Event < ActiveRecord::Base
  belongs_to :organization

  scope :starting_during, -> (time) { where("strftime('%m', start_time) = ?", time.strftime('%m')) }
end
