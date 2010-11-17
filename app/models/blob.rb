class Blob < ActiveRecord::Base
  validates :id, :presence => true
  validates :value, :presence => true
  attr_readonly :id, :value

  validate do |instance|
    if instance.value
      errors.add_to_base("id is not the sha of the value") unless instance.id == Digest::SHA1.hexdigest(instance.value)
    end
  end

  before_validation(:on => :create) do
    if self.value
      self.id = Digest::SHA1.hexdigest(self.value)
    end
  end
end
