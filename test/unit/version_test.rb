require 'test_helper'

class VersionTest < ActiveSupport::TestCase

  test 'cannot save something empty' do
    v = Version.new
    
    assert !v.save
  end
  
  test 'can save something not empty' do
    v = Version.new
    v.description = "new!"
    v.blob = Blob.new(:content => 'woot!')

    v.save!

    v2 = Version.new(:description => 'even newer', :blob => v.blob)

    v2.save!

    
  end

end
