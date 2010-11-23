require File.join(Rails.root, 'lib/import/blogger.rb')

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

      offset = 0
      begin
        current = Blob.limit(1).offset(offset).first
        if current
          if Import::Blogger.is_post?(current.value)
            puts current.value
          end
        end
        offset += 1
      end while current

    end

  end

end
