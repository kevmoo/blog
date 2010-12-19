require 'haml/html'

class Version < ActiveRecord::Base
  serialize :metadata, Hash
  belongs_to :blob, :readonly => true
  belongs_to :previous, :class_name => 'Version', :foreign_key => 'previous_id'
  attr_readonly :blob_id, :previous_id
  validates :blob_id, :presence => true
  validate :good_changes

  def self.convert_to_haml(version)
    unless version.format == 'html'
      raise 'foo'
    end
    haml = Haml::HTML.new(version.blob.value).render
    blob = Blob.get(haml)
    Version.new(:blob => blob, :format => 'haml')
  end

  private

  def good_changes
    if persisted?
      changes.keys.select{ |attrib| Version.readonly_attributes.include?(attrib)}.each do |attrib|
        errors[attrib] << "Cannot change after it's been saved"
      end
    end
  end
end
