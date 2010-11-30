require 'spec_helper'
include Import

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do

      describe "should import awesome" do
        count = 0
        Blogger.data_from_file(file).each do |entry|
          it "entry number #{count} should be cool" do
            entry[:alt_link].should match /j832\.com/
          end
          count += 1
        end
      end
    end
  end
end
