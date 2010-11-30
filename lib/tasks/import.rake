require File.join(Rails.root, 'lib/import/blogger.rb')

namespace :import do

  namespace :blogger do

    desc "Import all posts from spec data"
    task :import_all => :environment do
      files = Dir.glob(File.expand_path('../../../spec/data/blogger/*', __FILE__))
      files.each do |filename|
        puts "importing #{filename}"
        Import::Blogger.new(filename).entries.each do |entry|
          Import::Blogger.post_from_hash(entry)
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
