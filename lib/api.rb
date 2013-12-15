require 'uri'
require 'cgi'
require 'net/http'




module PDX911
  class API

    URL = 'http://www.portlandonline.com/scripts/911incidents.cfm'




    # Send an HTTP GET request to the 911 dispatch feed and return the response.
    def self.fetch_response
      uri = URI.parse(URL)
      response = Net::HTTP.get(uri.host, uri.path)
    end




  end
end