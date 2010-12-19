module Import
  class Blogger

    XMLNS = {
      :atom => 'http://www.w3.org/2005/Atom',
      :kind => 'http://schemas.google.com/g/2005#kind',
      :post => 'http://schemas.google.com/blogger/2008/kind#post',
      :app => 'http://purl.org/atom/app#'
    }.freeze

    SLUG_REGEX = /\/([\w-]*)\.html/

    def initialize(blogger_export_xml_path)
      @doc = get_nokogiri_doc(blogger_export_xml_path)
    end

    def entries
      entries_xml.select{ |xml| Blogger.is_post?(xml.to_xml) }.collect!{ |xml| Blogger.parse(xml) }
    end

    def self.post_from_hash(data, existing_urls = [], existing_slugs = [])
      return if existing_urls.include?(data[:alt_link])

      blob = Blob.get(data[:content])
      version = Version.create(:blob => blob, :metadata => data.reject{ |key, value| key == :content}, :format => 'html')
      post = Post.new(:version => version)
      unless existing_slugs.include?(data[:slug])
        post.slug = data[:slug]
      end
      post.title = data[:title].blank? ? nil : data[:title]
      post.created_at = data[:published]
      post.updated_at = data[:updated]
      post.save!
      post
    end

    private

    def self.parse(xml)
      xml = ensure_xml(xml)
      data = {}
      data[:blogger_id] = get_blogger_id(xml)
      data[:title] = get_title(xml)
      data[:published] = get_date(xml, 'published')
      data[:updated] = get_date(xml, 'updated')
      data[:content] = get_content(xml)
      data[:alt_link] = get_alt_link(xml)
      data[:slug] = get_slug(data[:alt_link])
      data
    end

    def self.is_post?(xml)
      xml = ensure_xml(xml)

      if xml.xpath('//app:draft', {'app' => XMLNS[:app]}).length > 0
        return false
      end

      xml.xpath('//category').each do |category|
        if category.attr('scheme') == XMLNS[:kind] && category.attr('term') == XMLNS[:post]
          return true
        end
      end
      return false
    end

    def entries_xml
      @doc.xpath("//atom:entry", 'atom' => XMLNS[:atom])
    end

    def self.get_slug(alt_link)
      alt_link.match(SLUG_REGEX)[1]
    end

    def self.get_alt_link(xml)
      links = get_links(xml)
      links.select!{ |l| l['rel'] == 'alternate'}
      assert links.length == 1, 'should have one and only one alternate link'
      links[0]['href']
    end

    def self.get_links(xml)
      link_elements = xml.xpath("atom:link", {'atom' => XMLNS[:atom]})
      link_elements.collect do |item|
        hash = {}
        item.attributes.each do |key, value|
          hash[key] = value.value
        end
        hash
      end
    end

    def self.get_date(xml, name)
      content = xml.xpath("atom:#{name}", {'atom' => XMLNS[:atom]})
      assert content.length == 1
      content = content[0]
      assert content.child.text?
      DateTime.parse(content.child.text)
    end

    def self.get_content(xml)
      content = xml.xpath('atom:content', {'atom' => XMLNS[:atom]})
      assert content.length == 1
      content = content[0]
      assert content.attributes['type'].value == 'html'
      assert content.child.text?
      content.child.text
    end

    def self.get_blogger_id(xml)
      blogger_id = xml.xpath('atom:id', {'atom' => XMLNS[:atom]})
      assert blogger_id.length == 1
      assert blogger_id[0].child.text?
      blogger_id[0].child.text
    end

    def self.get_title(xml)
      title_element = xml.xpath('atom:title', {'atom' => XMLNS[:atom]})
      assert title_element.length == 1
      title_element = title_element[0]
      assert title_element.attributes['type'].value == 'text'
      if title_element.child
        assert title_element.child.text?
        title_element.child.text
      else
        ''
      end
    end

    def self.assert(truth, message = nil)
      unless truth
        if message
          raise message
        else
          raise 'something weird happened'
        end
      end
    end

    def self.ensure_xml(xml)
      unless xml.respond_to?(:to_xml)
        xml = Nokogiri::XML(xml)
      end
      xml
    end

    def get_nokogiri_doc(filename)
      content = open_file(filename)
      Nokogiri::XML(content)
    end

    def open_file(filename)
      File.open(filename, 'r') do |file|
        return file.read
      end
    end

  end
end
