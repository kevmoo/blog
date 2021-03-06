class Blob < ActiveRecord::Base
  validates :id, :presence => true
  validates :value, :presence => true
  attr_readonly :id, :value

  validate do |instance|
    if instance.value
      instance.errors[:id] << ("id is not the sha of the value") unless instance.id == Digest::SHA1.hexdigest(instance.value)
    end
  end

  before_validation(:on => :create) do
    if self.value
      self.id = Digest::SHA1.hexdigest(self.value)
    end
  end

  def self.get(value)
    raise ArgumentError.new('value cannot be nil') if !value
    sha = Digest::SHA1.hexdigest(value)
    blob = Blob.find_by_id(sha)
    unless blob
      blob = Blob.create(:value => value)
    end
    blob
  end

end
