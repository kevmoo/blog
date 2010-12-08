require 'omniauth/core'
require 'omniauth/oauth'

throw 'twitter keys not defined!' unless ENV.key?('TWITTER_CONSUMER_KEY') && ENV.key?('TWITTER_CONSUMER_SECRET')

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
