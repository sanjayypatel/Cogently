module UsersHelper
  def feeds_to_links(user)
    return "" if user.feeds.nil?
    user.feeds.map { |feed| link_to feed.tag, user_feed_path(user, feed) }.join(', ').html_safe
  end
end