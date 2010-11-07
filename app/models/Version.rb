class Version
  include Mongoid::Document
  references_one :blob, :stored_as => :array
  references_one :previous, :class_name => 'Version', :stored_as => :array
  field :description
  field :created_at, :type => Date

  set_callback :save, :before, :set_created_at

  validate(:on => :update) do
    errors.add(:base, 'Cannot update an existing blob')
  end

  validates_presence_of :blob
  validates_presence_of :description

  def set_created_at
    self.created_at = Time.now.utc
  end

end
