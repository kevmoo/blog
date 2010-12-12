require 'omniauth/core'
require 'omniauth/oauth'

%w(TWITTER_CONSUMER_KEY TWITTER_CONSUMER_SECRET TWITTER_USER).each do |key|
  throw "a required environment var is not set: #{key}" unless ENV.key?(key)
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end
