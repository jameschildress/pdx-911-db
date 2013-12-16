module PDX911
  class Database



    CONNECTION_SETTINGS = {
      host:   'localhost',
      dbname: 'pdx911_dev'
    }
    
    RECORDS = [
      PDX911::Agency,
      PDX911::Category,
      PDX911::Dispatch
    ]



    # Convenience method for running code within a database connection.
    def self.connect
      db = PG::Connection.open(CONNECTION_SETTINGS)
      result = yield db
      db.close
      result
    end
    
        
    
    # Create the tables and indexes of the database.
    # If 'force_drop' is true, overwrite existing tables and indexes.
    def self.create_tables force_drop=false
      connect do |db|
        
        if force_drop
          tables = RECORDS.map { |rec| rec.table_name }.join(', ')
          db.exec "DROP TABLE IF EXISTS #{tables}"
        end

        RECORDS.each do |rec|
          schema = rec.schema.map { |k, v| "#{k} #{v}" }.join(', ')
          db.exec "CREATE TABLE #{rec.table_name} ( #{schema} )"
          db.exec "CREATE UNIQUE INDEX ON #{rec.table_name} (#{rec.index_column_name})"
        end

      end
    end
    
    
    
  end
end