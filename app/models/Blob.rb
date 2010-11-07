class Blob
  include Mongoid::Document

  field :content
  identity :type => String
  referenced_in :version

  validate(:on => :update) do
    errors.add(:base, 'Cannot update an existing blob')
  end

  # Generate an id for this +Document+.
  def identify
    ShaIdentity.new(self, content).create
  end

end
