require 'spec_helper'
require 'haml/html'
include Import

describe Import::Blogger do
  TEST_FILES.each do |file|
    describe "for file #{file}" do
      index = 0
      Blogger.new(file).entries.each do |entry|
        describe "should import index #{index} awesome" do

          it "'#{entry[:title]}' should import into a post nicely" do
            puts CGI::escapeHTML(entry[:content])
            puts Haml::HTML.new(entry[:content]).render
          end

        end
      end
    end
  end
end
