require File.join(Rails.root, 'lib/import/blogger.rb')

namespace :import do

  namespace :blogger do

    desc "Import all posts from spec data"
    task :import_all => :environment do
      files = Dir.glob(File.expand_path('../../../spec/data/blogger/*', __FILE__))
      
      all_posts = Post.all
      existing_urls = all_posts.collect { |p| p.version.metadata[:alt_link] }
      existing_slugs = all_posts.select{ |p| p.slug}.collect { |p| p.slug }
      files.each do |filename|
        puts "importing #{filename}"
        Import::Blogger.new(filename).entries.each do |entry|
          p = Import::Blogger.post_from_hash(entry, existing_urls, existing_slugs)
          if(p)
            existing_urls << p.version.metadata[:alt_link]
            if(p.slug)
              existing_slugs << p.slug
            end
          else
            puts "  Already have: #{entry[:alt_link]}"
          end
        end
      end
    end

    desc "Import posts from a blogger blog xml export"
    task :import, [:file_name] => :environment do |t, args|
      filename = args[:file_name]
      raise "required param #{:file_name} not defined" unless filename
      Import::Blogger.new(filename)
    end

  end

end
