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
      xml = self.ensure_xml(xml)
      data = {}
      data[:blogger_id] = xml.xpath('atom:id', {'atom' => XMLNS[:atom]})[0].text
      # title
      # title - format
      # created
      # updated
      # format
      # content
      data
    end

    def self.is_post?(xml)
      xml = self.ensure_xml(xml)
      xml.xpath('//category').each do |category|
        if category.attr('scheme') == XMLNS[:kind] && category.attr('term') == XMLNS[:post]
          return true
        end
      end
      return false
    end

    private

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
