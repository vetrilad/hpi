module InflationCalculator
  def compute_inflation(from_index, to_index, property_value)
    inflation = to_index/from_index
    (property_value.to_f * inflation).round(0)
  end
end
