module ApplicationHelper
  def pretty_path(post)
    options = post.get_options
    "/#{options[:year]}/%02d/#{options[:slug]}" % options[:month]
  end

  def user_data
    session[:user]
  end
end
