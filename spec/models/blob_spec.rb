require 'spec_helper'

describe Blob do
  it 'should not allow empty' do
    Blob.new.save.should be_false
  end

  it 'should have a valid sha as id' do
    b = Blob.new(:value => 'foo')

    b.save.should be_true
    b.id.should eq(Digest::SHA1.hexdigest('foo'))
  end

  it 'should support get class method' do
    start_value = "shanna bannana"

    sha = Digest::SHA1.hexdigest(start_value)
    b = Blob.find_by_id(sha)
    b.should be_nil
    b = Blob.get(start_value)
    b.should_not be_nil
    b.value.should eq(start_value)
    b2 = Blob.get(start_value)
    b2.should_not be_nil
    b2.id.should eq(b.id)
    b2.value.should eq(b.value)
  end

  it 'should not allow changing content or id'

end
