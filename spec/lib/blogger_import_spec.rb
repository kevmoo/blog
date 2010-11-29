require 'spec_helper'
include Import

TEST_FILES = Dir.glob(File.expand_path('../../data/blogger/*', __FILE__))

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do

      describe "should import awesome" do
        blogger = Blogger.new(file)

        count = 0
        blogger.entries.select{ |entry| Blogger.is_post?(entry.to_xml) }.each do |entry|
          it "entry number #{count} should be cool" do
            data = Blogger.parse(entry)
            data[:alt_link].should match /j832\.com/
          end
          count += 1
        end
      end
    end
  end
end
