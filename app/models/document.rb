class Document < ActiveRecord::Base
  require 'nokogiri'
  mount_uploader :file, FileUploader
  belongs_to :organization
  belongs_to :user
  has_many :paragraphs
  has_many :notes, through: :paragraphs
  acts_as_taggable
  scope :by_recently_updated, -> {order(created_at: :desc)}

  def path_to_file
    return "#{Rails.root}/public#{self.file.url}"
  end

  def process_new_document(content_as_html)
    parsed_document = Nokogiri::HTML(content_as_html)
    paragraphs = parsed_document.css 'p'
    paragraphs.each_with_index do |paragraph, index|
      unless paragraph.content.blank?
        @new_paragraph = Paragraph.new(
            content: "#{paragraph}",
            document: self
          )
        @new_paragraph.save
      end
    end
    return parsed_document.to_html
  end

end
