require 'dotenv'
Dotenv.load("environments/test.env")

require_relative '../lib/inflation_service'
require_relative '../lib/dm_hpi'
require_relative '../lib/api_controller'

require "rack/test"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/#{ENV['DB_NAME']}")
DataMapper.finalize

HousePriceIndex.auto_upgrade!
