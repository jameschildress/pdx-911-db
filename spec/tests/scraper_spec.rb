describe PDX911::Scraper do
  
  describe "run()" do
  
  
    
    before do
      # Reset database
      PDX911::Database.create_tables true
      # Populate from sample data
      scrape_sample_data :one
      # Get records
      PDX911::Database.connect do |db|
        @categories = PDX911::Category.all(db)
        @agencies   = PDX911::Agency.all(db)
        @dispatches = PDX911::Dispatch.all(db)
      end
    end



    it "creates a Category for every unique category" do
      @categories.size.must_equal 2
      @categories[0].name.must_equal 'UNWANTED PERSON'
      @categories[1].name.must_equal 'THEFT - COLD'
    end
    
    it "creates an Agency for every unique agency" do
      @agencies.size.must_equal 2
      @agencies[0].name.must_equal 'Portland Police'
      @agencies[1].name.must_equal 'Gresham Police'
    end


    
    it "creates a Dispatch for every entry" do
      @dispatches.size.must_equal 4
      
      @dispatches[0].uid.must_equal         'PP13000410538'
      @dispatches[0].address.must_equal     '1000 BLOCK OF SW YAMHILL ST, PORTLAND, OR'
      @dispatches[0].category_id.must_equal  @categories[0].id
      @dispatches[0].agency_id.must_equal    @agencies[0].id
      @dispatches[0].location.must_equal    '(45.51965,-122.682966)'
      DateTime.parse(@dispatches[0].date).must_equal DateTime.parse('2013-12-16T16:04:09.0-08:00')
      
      @dispatches[1].uid.must_equal         'PG13000069877'
      @dispatches[1].address.must_equal     '19400 BLOCK OF E BURNSIDE ST, GRESHAM, OR'
      @dispatches[1].category_id.must_equal  @categories[1].id
      @dispatches[1].agency_id.must_equal    @agencies[1].id
      @dispatches[0].location.must_equal    '(45.51701,-122.463297)'
      DateTime.parse(@dispatches[1].date).must_equal DateTime.parse('2013-12-16T16:01:01.0-08:00')
      
      @dispatches[2].uid.must_equal         'PP13000410477'
      @dispatches[2].address.must_equal     '1100 BLOCK OF NE 80TH AVE, PORTLAND, OR'
      @dispatches[2].category_id.must_equal  @categories[1].id
      @dispatches[2].agency_id.must_equal    @agencies[0].id
      @dispatches[0].location.must_equal    '(45.531446,-122.580687)'
      DateTime.parse(@dispatches[2].date).must_equal DateTime.parse('2013-12-16T15:31:09.0-08:00')
      
      @dispatches[3].uid.must_equal         'PP13000410491'
      @dispatches[3].address.must_equal     '17100 BLOCK OF SE POWELL BLVD, PORTLAND, OR'
      @dispatches[3].category_id.must_equal  @categories[0].id
      @dispatches[3].agency_id.must_equal    @agencies[0].id
      @dispatches[0].location.must_equal    '(45.491989,-122.488314)'
      DateTime.parse(@dispatches[3].date).must_equal DateTime.parse('2013-12-16T15:23:32.0-08:00')
    end
  
  
    
    it "does not create records that already exist" do
      scrape_sample_data :one
      PDX911::Database.connect do |db|
        PDX911::Category.all(db).size.must_equal 2
        PDX911::Agency.all(db).size.must_equal 2
        PDX911::Dispatch.all(db).size.must_equal 4
      end
    end


    
  end
  
end
  
  
  