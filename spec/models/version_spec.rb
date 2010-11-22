require 'spec_helper'

describe Version do
  it 'should not allow empty' do
    Version.new.save.should be_false
  end

  it 'should allow valid' do
    v = Version.new(:blob => Blob.create(:value => "foo"))
    v.save!
  end
end
