class Document < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :organization
  belongs_to :user

  acts_as_taggable
end
