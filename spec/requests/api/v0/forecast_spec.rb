# spec/requests/api/v0/forecast_spec.rb

require 'rails_helper'

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast" do
    before do
      get "/api/v0/forecast?location=denver,co"
      expect(response.status).to eq(200)

      @response_data = JSON.parse(response.body, symbolize_names: true)[:data]
    end

    it 'returns the weather for a city', :vcr do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly('data')
      expect(json['data'].keys).to contain_exactly('id', 'type', 'attributes')
      expect(json['data']['attributes'].keys).to contain_exactly('current_weather', 'daily_weather', 'hourly_weather')
      expect(json['data']['attributes']['current_weather']).not_to include('unwanted_field')
    end

    it 'does not return unnecessary data for a city', :vcr do
      expect(@response_data).not_to have_key(:updated_at)
      expect(@response_data).not_to have_key(:created_at)
      
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:is_day)
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:wind_mph)
      expect(@response_data[:attributes][:current_weather]).not_to have_key(:wind_degree)

      expect(@response_data[:attributes][:daily_weather][0]).not_to have_key(:maxwind_mph)
      expect(@response_data[:attributes][:daily_weather][0]).not_to have_key(:avg_humidity)

      expect(@response_data[:attributes][:hourly_weather][0]).not_to have_key(:wind_dir)
      expect(@response_data[:attributes][:hourly_weather][0]).not_to have_key(:cloud)
    end
  end
end
