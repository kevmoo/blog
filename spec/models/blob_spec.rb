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
end
