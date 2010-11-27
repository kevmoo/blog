module Import
  class Blogger

    XMLNS = {
      :atom => 'http://www.w3.org/2005/Atom',
      :kind => 'http://schemas.google.com/g/2005#kind',
      :post => 'http://schemas.google.com/blogger/2008/kind#post'
    }

    def initialize(blogger_export_xml_path)
      @doc = get_nokogiri_doc(blogger_export_xml_path)
    end

    def save
      entries.each do |entry|
        Blob.get(entry.to_xml)
      end
    end

    def entries
      @doc.xpath("//atom:entry", 'atom' => XMLNS[:atom])
    end

    def self.parse(xml)
      xml = ensure_xml(xml)
      data = {}
      data[:blogger_id] = get_blogger_id(xml)
      data[:title] = get_title(xml)
      # title
      # title - format
      # created
      # updated
      # format
      # content
      data
    end

    def self.is_post?(xml)
      xml = ensure_xml(xml)
      xml.xpath('//category').each do |category|
        if category.attr('scheme') == XMLNS[:kind] && category.attr('term') == XMLNS[:post]
          return true
        end
      end
      return false
    end

    private

    def self.get_blogger_id(xml)
      assert xml.respond_to?(:to_xml)
      blogger_id = xml.xpath('atom:id', {'atom' => XMLNS[:atom]})
      assert blogger_id.length == 1
      assert blogger_id[0].child.text?
      blogger_id[0].child.text
    end

    def self.get_title(xml)
      assert xml.respond_to?(:to_xml)
      blogger_id = xml.xpath('atom:title', {'atom' => XMLNS[:atom]})
      assert blogger_id.length == 1
      blogger_id = blogger_id[0]
      if blogger_id.child
        assert blogger_id.child.text?
        blogger_id.child.text
      else
        ''
      end
    end

    def self.assert(truth, message = nil)
      unless truth
        if message
          raise 'message'
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
