ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # teardown :clean_mongodb


  def clean_mongodb
    puts "cleaning mongodb...."
    Mongoid.database.collections.each do |collection|
      unless collection.name =~ /^system\./
        collection.remove
      end
    end
    puts "finished cleaning mongodb."
  end
end
