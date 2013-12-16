module PDX911
  class Agency < Record
    
   
    
    def self.table_name
      'agencies'
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