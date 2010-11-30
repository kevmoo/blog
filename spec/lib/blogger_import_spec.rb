require 'spec_helper'
include Import

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do
      index = 0
      Blogger.data_from_file(file).each do |entry|
        describe "should import index #{index} awesome" do

          it "should be valid data" do
            entry[:alt_link].should match /j832\.com/
          end

          it "'#{entry[:title]}' should import into a post nicely" do
            p = Blogger.post_from_hash(entry)
          end

          index += 1
        end
      end
    end
  end
end
