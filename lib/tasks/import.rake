require File.join(Rails.root, 'lib/import/blogger.rb')

namespace :import do
  desc "Import posts from a blogger blog xml export"
  task :blogger => :environment do

    filename = ENV['IMPORT_FILE']
    unless filename
      filename = '/Users/kevin/source/github/myblog/content/personal_blog-11-21-2010.xml'
    end

    reader =  Import::Blogger.get_nokogiri_doc(filename)

  end
end
