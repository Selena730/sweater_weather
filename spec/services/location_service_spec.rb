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
end
