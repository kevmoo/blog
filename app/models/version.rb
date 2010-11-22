class Version < ActiveRecord::Base
  serialize :metadata, Hash
  belongs_to :blob, :readonly => true
  has_one :previous, :class_name => "Version", :foreign_key => "previous_id"
  validates :blob_id, :presence => true

  before_validation(:on => :save) do
    self.metadata ||= {}
  end
end
