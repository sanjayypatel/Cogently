class Summary < ActiveRecord::Base
  belongs_to :document
  has_and_belongs_to_many :events
end
