module EventsHelper
  def summaries_to_links(event)
    return "" if event.summaries.nil?
    event.summaries.map { |summary| 
      link_to "#{summary.document.name}", document_summary_path(summary.document, summary) 
      }.join(', ').html_safe
  end
end