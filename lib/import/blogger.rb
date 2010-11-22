module Import
  class Blogger

    XMLNS = {:atom => 'http://www.w3.org/2005/Atom'}

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

    private

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
