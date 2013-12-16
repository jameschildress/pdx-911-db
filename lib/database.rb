module PDX911
  class Database



    CONNECTION_SETTINGS = {
      host:   'localhost',
      dbname: 'pdx911_dev'
    }



    def self.connect
      db = PG::Connection.open(CONNECTION_SETTINGS)
      yield db
      db.close
    end
        
    def self.create_tables force_drop=false
      connect do |db|
        PDX911::Record.descendants.each do |klass|
          klass.create_table db, force_drop
        end
      end
    end
    
    
    
  end
end