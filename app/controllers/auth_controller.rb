class AuthController < ApplicationController
  def twitter_callback
    omni_hash = request.env['omniauth.auth']
    if omni_hash
      nick = omni_hash['user_info']['nickname']
      if omni_hash['uid'] == ENV['TWITTER_UID']
        session[:user] = omni_hash['user_info']
        flash[:notice] = "Welcome, #{nick}"
      else
        session.delete(:user)
        flash[:notice] = "Sorry #{nick}. I don't know you"
      end
    end
    redirect_to :root
  end
end
