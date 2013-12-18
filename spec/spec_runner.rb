require 'minitest/spec'
require 'minitest/autorun'

require "#{__dir__}/../lib/pdx911"

Dir["#{__dir__}/tests/**/*.rb"].each do |file|
  require file
end




# Use 'test' database.
PDX911::Database::CONNECTION_SETTINGS = {
  host:   'localhost',
  dbname: 'pdx911_test',
  options: '--client-min-messages=warning'
}
