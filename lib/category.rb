module PDX911
  class Category < Record
    
    
    
    def self.table_name
      'categories'
    end
    
    def self.schema
      {
        name: 'varchar(80)'
      }
    end
    
    def self.index_column_name
      'name'
    end
    
    
    
  end
end