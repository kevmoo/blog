require 'spec_helper'

describe Version do
  it 'should not allow empty' do
    Version.new.save.should be_false
  end

  it 'should allow valid' do
    b = Blob.create(:value => "foo")
    v = Version.new(:blob => b)

    v.save!
  end
end
