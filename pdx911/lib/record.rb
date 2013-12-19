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
      db.exec "CREATE UNIQUE INDEX #{table_name}_#{index_column_name}_idx ON #{table_name} (#{index_column_name})"
    end
    
    # Iterate through the rows of a PG::Result and return an array of Records.
    def self.init_from_result pg_result
      pg_result.to_a.map do |hash|
        self.new hash
      end
    end
        
    def self.all db
      init_from_result db.exec("SELECT * FROM #{table_name}")
    end
    
    def self.find_by_index db, value
      init_from_result db.exec_params("SELECT * FROM #{table_name} WHERE #{index_column_name} IN ($1)", [value])
    end
    
    def self.find_by_id db, value
      init_from_result db.exec_params("SELECT * FROM #{table_name} WHERE id IN ($1)", [value])      
    end
    
    def self.create db, hash
      columns = hash.keys.join(',')
      placeholders = hash.size.times.map { |i| "$#{i + 1}" }.join(',')
      init_from_result db.exec_params("INSERT INTO #{table_name} (#{columns}) VALUES (#{placeholders}) RETURNING *", hash.values)
    end
    
    def self.find_or_create_by_index db, value
      result = find_by_index(db, value)
      result.empty? ? create(db, { index_column_name => value }) : result
    end

    
    
    # Create a getter method for each column in the schema.
    def initialize hash
      (self.class.schema.keys << :id).each do |column|
         define_singleton_method(column) { hash[column.to_s] }
      end
    end
    
    def inspect
      attrs = (self.class.schema.keys << :id).map do |column|
        "#{column}: #{send(column)}"
      end
      "<#{self.class} {#{attrs.join(', ')}}>"
    end
    
    def to_s
      inspect
    end
    
    
    
  end
end