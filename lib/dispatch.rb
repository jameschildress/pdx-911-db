module PDX911
  class Dispatch < Record
    
    
    
    def self.table_name
      'dispatches'
    end
    
    def self.schema
      {
        category_id: 'int',
        agency_id:   'int',
        location:    'point',
        uid:         'varchar(30)',
        address:     'varchar(200)' 
      }
    end
    
    def self.index_column_name
      'uid'
    end
    
    
    
  end
end