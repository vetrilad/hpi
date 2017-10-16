require_relative './dm_hpi'
require_relative './inflation_calculator'

class InflationService
  include InflationCalculator

  def get_inflation(region_name: ,from: ,to: , property_value:)
    hpi_entries = ( HousePriceIndex.all(region_name: region_name, date: from) |
                    HousePriceIndex.all(region_name: region_name, date: to)
                  ).all(order: [:date.asc])

    return nil if hpi_entries.size < 2

    compute_inflation(hpi_entries[0].hpi_index, hpi_entries[1].hpi_index, property_value)
  end
end
  
