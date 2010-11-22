module Import
  module Blogger

    def self.get_entries(filename)

    end


    private

    def self.get_nokogiri_doc(filename)
      content = open_file(filename)
      Nokogiri::XML(content)
    end

    def self.open_file(filename)
      File.open(filename, 'r') do |file|
        return file.read
      end
    end

  end
end



def get_posts(xs)
  posts = []

  xs['entry'].each do |entry|
    categories = entry['category']

    if categories.any?{ |category| category['term'] == 'http://schemas.google.com/blogger/2008/kind#post'}

      np = {}
      np['tags'] = entry['category'].find_all{ |cat| cat['term'][0,5] != 'http:'}.collect{ |cat| cat['term'] }
      np['title'] = entry['title'][0]['content']
      np['published'] = DateTime.parse(entry['published'][0]).utc.to_s
      np['id'] = entry['id'][0]
      np['content'] = entry['content']['content']

      link = entry['link'].find{ |link| link['rel'] == 'alternate'}
      if(link != nil)
        np['original_url'] = link['href']
      end

      posts << np
    end

  end

  return posts

end

#posts = get_posts(xs)

def save_hash_to_json(obj, file_name)
  File.open(file_name, 'w') do |file|

    file.write obj.to_json

  end
end

#save_hash_to_json(posts, "#{file_name}.posts.json")
