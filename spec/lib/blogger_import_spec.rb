require 'spec_helper'
include Import

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do
      index = 0
      Blogger.new(file).entries.each do |entry|
        describe "should import index #{index} awesome" do

          it "should be valid data" do
            entry[:alt_link].should match /j832\.com/
          end

          it "'#{entry[:title]}' should import into a post nicely" do
            p = Blogger.post_from_hash(entry)
            p.save!
          end

          it "shoud covert to haml fine" do
            p = Blogger.post_from_hash(entry)
            p.save!

            puts CGI::escapeHTML(p.to_html)

            version = p.version
            version.format.should eq('html')
            new_version = Version.convert_to_haml(version)
            new_version.format.should eq('haml')
            new_version.previous.should eq(version)
          end

          index += 1
        end
      end
    end
  end
end
