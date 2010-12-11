class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :maybe_public

  private

  def maybe_public
    if !session[:user]
      response.headers['Cache-Control'] = 'public'
    end
  end

end
