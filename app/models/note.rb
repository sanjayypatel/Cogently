class Note < ActiveRecord::Base
  belongs_to :paragraph
  belongs_to :user

  def to_s
    return "#{self.user.name}: #{self.body}"
  end
end
