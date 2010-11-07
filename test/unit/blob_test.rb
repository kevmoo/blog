require 'test_helper'
require 'digest/sha1'

class BlobTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  test "cannot update" do
    b = Blob.new(:content => get_random_string)
    assert b.save

    b.content = 'foo'

    assert !b.save
  end

  test "key == _id == sha" do
    b = Blob.new(:content => get_random_string)
    sha = Digest::SHA1.hexdigest(b.content)

    assert_equal sha, b.id

    assert b.save

  end

  test "no content" do
    b = Blob.new

    assert_equal 'nil', b.id

    b.save!
  end

  private

  def get_random_string
    "should be random"
  end
end
