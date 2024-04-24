require 'rails_helper'

RSpec.describe LocationService, type: :service do
  describe '.coordinates' do
    it 'retrieves coordinates for a given location' do
      location = "Denver, CO"
      stubbed_response = {
        results: [{
          locations: [{
            latLng: { lat: 39.7392, lng: -104.9903 }
          }]
        }]
      }

      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address")
        .with(query: hash_including({ "key" => Rails.application.credentials.mapquest[:key], "location" => location }))
        .to_return(status: 200, body: stubbed_response.to_json, headers: { 'Content-Type' => 'application/json' })

      coordinates = LocationService.coordinates(location)

      expect(coordinates).to eq({ lat: 39.7392, lng: -104.9903 })
      expect(WebMock).to have_requested(:get, "https://www.mapquestapi.com/geocoding/v1/address")
        .with(query: { "key" => Rails.application.credentials.mapquest[:key], "location" => location })
    end
  end

  describe '.get_route' do
    it 'returns the formatted time if route is found' do
      successful_response = {
        info: { statuscode: 0 },
        route: { formattedTime: '02:30:00' }
      }
      allow(LocationService).to receive(:get_url).and_return(successful_response)

      result = LocationService.get_route('Denver, CO', 'Boulder, CO')

      expect(result[:route][:formattedTime]).to eq('02:30:00')
    end

    it 'returns if route is not found' do
      failed_response = {
        info: { statuscode: 1 },  
        route: {}
      }
      allow(LocationService).to receive(:get_url).and_return(failed_response)
  
      result = LocationService.get_route('New York, NY', 'London, UK')  
  
      expect(result[:route][:formattedTime]).to be_nil
    end
  end
end
