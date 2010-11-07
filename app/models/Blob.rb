class Blob
  include Mongoid::Document

  field :content
  identity :type => String

  before_validation do
    # no worky if not new -> objects are created once
    return self.new_record?
  end

  # Generate an id for this +Document+.
  def identify
    ShaIdentity.new(self, content).create
  end

end
