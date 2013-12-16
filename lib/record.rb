module PDX911
  class Record
    
    
    
    def self.table_name
      raise NotImplementedError
    end
    
    def self.schema
      raise NotImplementedError
    end
    
    def self.index_column_name
      raise NotImplementedError
    end
    
    
    
    def all db

    end
    
    def find_or_create db

    end
    
    
    
  end
end