class Document < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :organization
  belongs_to :user

  acts_as_taggable
  scope :by_recently_updated, -> {order(created_at: :desc)}
end
