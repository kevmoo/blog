class Version < ActiveRecord::Base
  serialize :metadata, Hash
  has_one :blob, :class_name => "Blob", :foreign_key => "blob_id"
  has_one :previous, :class_name => "Version", :foreign_key => "previous_id"
  validates :blob_id, :presence => true
  validates :metadata, :presence => true

  before_validation(:on => :create) do
    self.metadata ||= {}
  end
end
