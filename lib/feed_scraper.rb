require 'rubygems'
require 'bundler/setup'

require 'pg'

require 'uri'
require 'cgi'
require 'net/http'
require 'rexml/document'




module PDX911
  class FeedScraper




    DATABASE_CONNECTION = {
      host:   'localhost',
      dbname: 'pdx911_dev'
    }
    
    
    DATABASE_TABLES = {
      agencies: {
        name: 'varchar(80)'
      },
      categories: {
        name: 'varchar(80)'      
      },
      dispatches: {
        category_id: 'int',
        agency_id:   'int',
        location:    'point',
        uid:         'varchar(30)',
        address:     'varchar(200)' 
      }
    }
    
    
    API_URI = URI.parse('http://www.portlandonline.com/scripts/911incidents.cfm')
    
    
    
    
    # Convenience method for running code within a database connection.
    def self.database_session
      db = PG::Connection.open(DATABASE_CONNECTION)
      yield db
      db.close
    end
    
    
    # Create the tables of the database.
    # If 'force_drop' is true, overwrite existing tables.
    def self.create_tables force_drop=false
      database_session do |db|
        db.exec("DROP TABLE #{DATABASE_TABLES.keys.join(', ')}") if force_drop
        DATABASE_TABLES.each do |table_name, columns|
          columns = columns.map { |k, v| "#{k} #{v}" }.join(', ')
          db.exec "CREATE TABLE #{table_name} ( #{columns} )"
        end
      end
    end
    
    
    # Send an HTTP GET request to the 911 dispatch feed and return the response as XML.
    def self.api_response_xml
      response = Net::HTTP.get(API_URI.host, API_URI.path)
      REXML::Document.new response
    end



    
  end
end