module PDX911
  class Scraper
    
    
    
    def self.run
      xml = REXML::Document.new(PDX911::API.fetch_response)
      xml.elements.each('feed/entry') do |entry_node|
        dd_nodes = REXML::Document.new(CGI.unescapeHTML(entry_node.elements['content'].text)).get_elements('dl/dd')
        uid           = dd_nodes[0].text
        category_name = dd_nodes[1].text
        address       = dd_nodes[2].text
        agency_name   = dd_nodes[3].text
        date_text     = dd_nodes[4].text
        location      = entry_node.elements['georss:point'].text
      end
    end
    
    
    
  end
end