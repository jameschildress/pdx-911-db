module PDX911
  class Record
    
    
    
    @@descendants = []
    def self.inherited klass
      @@descendants << klass
    end
    def self.descendants
      @@descendants
    end
    
    
    
    def self.table_name
      raise NotImplementedError
    end
    
    def self.schema
      raise NotImplementedError
    end
    
    def self.index_column_name
      raise NotImplementedError
    end
    
    
    
    def self.create_table db, force_drop=false
      schema_string = schema.map { |k, v| "#{k} #{v}" }.join(', ')
      db.exec("DROP TABLE IF EXISTS #{table_name}") if force_drop
      db.exec "CREATE TABLE #{table_name} ( #{schema_string} )"
      db.exec "CREATE UNIQUE INDEX ON #{table_name} (#{index_column_name})"
    end
    
    def self.all db
      db.exec_params "SELECT * FROM $1", [table_name]        
    end
    
    def self.find_or_create db, index_column_value

    end
    
    
    
  end
end