require 'rubygems'
require 'bundler/setup'
require 'pg'




module PDX911
  class Database

    CONNECTION_SETTINGS = {
      host:   'localhost',
      dbname: 'pdx911_dev'
    }
    
    TABLES = {
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
    
    INDEXES = {
      agencies:   :name,
      categories: :name,
      dispatches: :uid
    }




    # Convenience method for running code within a database connection.
    def self.connect
      db = PG::Connection.open(CONNECTION_SETTINGS)
      yield db
      db.close
    end
    
    
    # Create the tables and indexes of the database.
    # If 'force_drop' is true, overwrite existing tables and indexes.
    def self.create_tables force_drop=false
      connect do |db|
        
        if force_drop
          tables = TABLES.keys.join(', ')
          db.exec "DROP TABLE IF EXISTS #{tables}"
        end

        TABLES.each do |table, columns|
          columns = columns.map { |k, v| "#{k} #{v}" }.join(', ')
          db.exec "CREATE TABLE #{table} ( #{columns} )"
        end
        
        INDEXES.each do |table, column|
          db.exec "CREATE UNIQUE INDEX ON #{table} (#{column})"
        end
        
      end
    end
    
    

    
  end
end