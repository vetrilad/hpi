describe InflationService do
  let(:service) { InflationService.new }

  before do
    HousePriceIndex.destroy
    HousePriceIndex.create(region_name: "SomeVille", date: "2015-08-01",hpi_index: 28.25)
    HousePriceIndex.create(region_name: "SomeVille", date: "2015-08-02",hpi_index: 103.60)
  end

  it 'calculates the infaltion' do
    inflation = service.get_inflation({region_name: 'SomeVille', from: '2015-08-01', to: '2015-08-02', property_value: 100000})
    expect(inflation).to eq 366726
  end

  it 'returns nil when no data was found' do
    inflation = service.get_inflation({region_name: 'NoVille', from: 'now',to: 'then', property_value: 100000})
    expect(inflation).to eq nil
  end
end
