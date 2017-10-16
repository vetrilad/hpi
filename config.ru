require 'dotenv'
Dotenv.load("environments/development.env")

require 'data_mapper'
require_relative './lib/api_controller'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/#{ENV['DB_NAME']}")

run ApiController
