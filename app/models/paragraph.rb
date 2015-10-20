class Paragraph < ActiveRecord::Base
  belongs_to :document
  has_many :notes
end
