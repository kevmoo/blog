# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# I'm using environment vars defined in initializers/dev_only.rb
# This file is ignored by .gitignore
throw 'No secret is defined in ENV[SECRET_TOKEN]' unless ENV.key?('SECRET_TOKEN')
Blog::Application.config.secret_token = ENV['SECRET_TOKEN']
