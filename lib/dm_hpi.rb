require 'data_mapper'

class HousePriceIndex
  include DataMapper::Resource

  property :region_name, String, :key => true
  property :date, Date, :key => true
  property :hpi_index, Float
end
