require 'spec_helper'

describe Version do
  it 'should not allow empty' do
    Version.new.save.should be_false
  end

  it 'should allow valid' do
    v = Version.new(:blob => Blob.get('foo'))
    v.save!
  end

  it 'should allow versioning coolness' do
    v = Version.create(:blob => Blob.get('foo'))
    v.id.should_not eq(nil)

    v2 = Version.create(:blob => Blob.get('bar'), :previous => v)
    v2.previous_id.should eq(v.id)

    v2.previous_id = nil
    v2.save.should be_false
  end
end
