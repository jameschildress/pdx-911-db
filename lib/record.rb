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
    
    
    
    # Create the database table for this record.
    # - A primary key of 'id' is added to the table columns.
    # - A unique index is created for the record's index_column_name.
    # If 'force_drop' is true, the existing database table will be dropped.
    def self.create_table db, force_drop=false
      schema_string = schema.merge({ id: 'SERIAL PRIMARY KEY' }).map { |k, v| "#{k} #{v}" }.join(', ')
      db.exec("DROP TABLE IF EXISTS #{table_name}") if force_drop
      db.exec "CREATE TABLE #{table_name} ( #{schema_string} )"
      db.exec "CREATE UNIQUE INDEX ON #{table_name} (#{index_column_name})"
    end
    
    def self.all db
      db.exec("SELECT * FROM #{table_name}").to_a
    end
    
    def self.find_by_index db, value
      db.exec_params("SELECT * FROM #{table_name} WHERE #{index_column_name} IN ($1)", [value]).to_a
    end
    
    
    
  end
end