module PDX911
  class Database



    CONNECTION_SETTINGS = {
      host:     'localhost',
      dbname:   ENV['PDX911_DATABASE_NAME'],
      user:     ENV['PDX911_DATABASE_USER'],
      password: ENV['PDX911_DATABASE_PASSWORD']
    }



    def self.connect
      db = PG::Connection.open(CONNECTION_SETTINGS)
      result = yield(db)
      db.close
      result
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