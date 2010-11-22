require File.join(Rails.root, 'lib/import/blogger.rb')

def parse(entry)
  puts entry.inspect
end

namespace :import do

  namespace :blogger do

    desc "Import posts from a blogger blog xml export"
    task :import => :environment do

      filename = ENV['IMPORT_FILE']
      unless filename
        filename = '/Users/kevin/source/github/myblog/content/personal_blog-11-21-2010.xml'
      end

      Import::Blogger.new(filename).save

    end

    desc "Posts for blobs"
    task :to_posts => :environment do

    end

  end

end
