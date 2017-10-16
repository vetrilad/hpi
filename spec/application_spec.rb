describe 'Api' do
  include Rack::Test::Methods

  let(:app) do
      ApiController
  end

  it 'gets the inflation' do
    allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)

    get '/api/inflation',location: 'Someville', fromDate: 'now', toDate: 'then', propertyValue: 100000

    expect(last_response).to be_ok
  end

  describe 'return a 400 when data has wrong format' do
    it 'no property Value' do
      allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)
      get '/api/inflation', location: 'Someville', fromDate: 'now', toDate: 'then'

      expect(last_response.status).to be 400
    end

    it 'no to Date' do
      allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)
      get '/api/inflation', location: 'Someville', fromDate: 'now', propertyValue: 100000

      expect(last_response.status).to be 400
    end

    it 'no from Date' do
      allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)
      get '/api/inflation', location: 'Someville', toDate: 'now', propertyValue: 100000

      expect(last_response.status).to be 400
    end

    it 'no location' do
      allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)
      get '/api/inflation', toDate: 'now', fromDate: 'now', propertyValue: 100000

      expect(last_response.status).to be 400
    end
  end

  it 'gets the correct inflation' do
    allow(app.settings.inflation_service).to receive(:get_inflation).and_return(366726)

    get '/api/inflation',location: 'Someville', fromDate: 'now', toDate: 'then', propertyValue: 100000

    response = JSON.parse(last_response.body, :symbolize_names => true)
    expect(response).to eq({inflated_price: 366726})
  end

  it 'returns 404 status when no inflation could be computed' do
    allow(app.settings.inflation_service).to receive(:get_inflation).and_return(nil)

    get '/api/inflation',location: 'Someville', fromDate: 'now', toDate: 'then', propertyValue: 100000

    expect(last_response.status).to be 404
  end
end
