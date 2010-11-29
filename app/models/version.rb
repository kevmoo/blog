class Version < ActiveRecord::Base
  serialize :metadata, Hash
  belongs_to :blob, :readonly => true
  belongs_to :previous, :class_name => 'Version', :foreign_key => 'previous_id'
  attr_readonly :blob_id, :previous_id
  validates :blob_id, :presence => true
  validate :good_changes

  private

  def good_changes
    if persisted?
      changes.keys.select{ |attrib| Version.readonly_attributes.include?(attrib)}.each do |attrib|
        errors[attrib] << "Cannot change after it's been saved"
      end
    end
  end
end
