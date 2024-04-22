require 'rails_helper'

RSpec.describe WeatherService, type: :service do
  describe '.fetch_weather' do
    let(:coordinates) { "39.7392,-104.9903" } # Denver, CO

    describe 'when the API call is successful' do
      before do
        
        stub_request(:get, "http://api.weatherapi.com/v1/forecast.json")
          .with(query: { "q" => coordinates, "days" => "6", "key" => Rails.application.credentials.weather["key"] })
          .to_return(status: 200, body: {
            current: { temp_c: 20.5, condition: { text: "Sunny" } },
            forecast: { forecastday: [{ date: "2023-05-01", day: { maxtemp_c: 21, condition: { text: "Partly cloudy" } } }] }
          }.to_json)
      end

      it 'fetches weather data correctly' do
        result = WeatherService.fetch_weather(coordinates)
        expect(result[:current]).to include(temp_c: 20.5)
        expect(result[:forecast]).to be_an(Array)
        expect(result[:forecast].first[:date]).to eq("2023-05-01")
      end
    end
  end
end
