require 'sinatra'
require 'json'
require 'data_mapper'
require_relative './dm_hpi'
require_relative './inflation_service'

class ApiController < Sinatra::Base
  DataMapper.finalize

  set :inflation_service, InflationService.new

  get '/api/inflation' do
    halt 400 unless params["location"] && params["fromDate"] && params["toDate"] && params["propertyValue"]

    inflated_price = settings.inflation_service.get_inflation(
      region_name: params["location"],
      from: params["fromDate"],
      to: params["toDate"],
      property_value: params["propertyValue"]
    )

    return 404 if inflated_price == nil

    { inflated_price: inflated_price }.to_json
  end
end
