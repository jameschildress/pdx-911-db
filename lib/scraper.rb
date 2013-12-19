module PDX911
  class Scraper
    
    
    
    def self.run
      xml = REXML::Document.new(PDX911::API.fetch_response)
      PDX911::Database.connect do |db|
        
        xml.elements.each('feed/entry') do |entry_node|
          dd_nodes = REXML::Document.new(CGI.unescapeHTML(entry_node.elements['content'].text)).get_elements('dl/dd')
          uid = dd_nodes[0].text
          if PDX911::Dispatch.find_by_index(db, uid).empty?
            PDX911::Dispatch.create({
              uid:         uid                                                                ,
              category_id: PDX911::Category.find_or_create_by_index(db, dd_nodes[1].text).id  ,
              address:     dd_nodes[2].text                                                   ,
              agency_id:   PDX911::Agency.find_or_create_by_index(db, dd_nodes[3].text).id    ,
              date:        dd_nodes[4].text                                                   ,
              location:    entry_node.elements['georss:point'].text.gsub(' ', ', ')
            })
          end
        end
      
      end
    end
    
    
    
  end
end