require 'spec_helper'
include Import

TEST_FILES = Dir.glob(File.expand_path('../../data/blogger/*', __FILE__))

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do

      describe "should import awesome" do
        blogger = Blogger.new(file)

        blogger.entries.select{ |entry| Blogger.is_post?(entry.to_xml) }.each do |entry|
          count = 0
          it "entry number #{count} should be cool" do
            puts CGI.escapeHTML(entry.to_xml)
          end
          count += 1
        end
      end
    end
  end
end
