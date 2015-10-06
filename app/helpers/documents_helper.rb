module DocumentsHelper
  def tags_to_links(tags)
    tags.map { |t| link_to t, tag_path(t.id) }.join(', ').html_safe
  end
end