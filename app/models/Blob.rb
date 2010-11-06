# require 'digest/sha1'
# Digest::SHA1.hexdigest 'foo'

class Blob
  include Mongoid::Document

  before_validation do
    return self.new_record?
  end
  
  field :content
  field :sha
  index :sha, :unique => true
  key :sha
end
