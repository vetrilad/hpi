require 'csv'
require 'dotenv'
Dotenv.load("environments/development.env")

require_relative './lib/dm_hpi'

task :migrate do
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/#{ENV['DB_NAME']}")
  DataMapper.finalize

  HousePriceIndex.auto_upgrade!

  CSV.foreach(ENV['CSV_FILENAME'], {:headers => false}) do |row|
    HousePriceIndex.create(date: row[0], region_name: row[1], hpi_index: row[4])
  end
end
