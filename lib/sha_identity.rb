require 'digest/sha1'

class ShaIdentity < Mongoid::Identity
  def initialize(document, content)
    @document = document
    @sha = Digest::SHA1.hexdigest(content) if content
  end

  # Set the id for the document.
  def identify!
    @document.id = @sha
    @document.id = 'nil' if @document.id.blank?
  end
end
