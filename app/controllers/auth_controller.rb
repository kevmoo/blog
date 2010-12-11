class AuthController < ApplicationController
  def twitter_callback
    omni_hash = request.env['omniauth.auth']
    puts omni_hash.inspect
    if omni_hash && omni_hash['uid'] == ENV['TWITTER_UID']
      session[:user] = omni_hash['user_info']
    end
    redirect_to :root
  end
end
