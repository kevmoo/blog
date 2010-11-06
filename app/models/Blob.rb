require 'digest/sha1'

class Blob
  include Mongoid::Document

  field :content
  field :sha
  index :sha, :unique => true
  key :sha

  before_validation do
    # no worky if not new -> objects are created once
    return self.new_record?
  end


  def sha
    val = read_attribute(:sha)
    if self.content && !val
      val = Digest::SHA1.hexdigest(self.content)
      write_attribute(:sha, val)
    end
    val
  end

end
