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
      origin = 'Denver, CO'
      destination = 'Boulder, CO'
      successful_response = {
        info: { statuscode: 0 },
        route: { formattedTime: '02:30:00' }
      }
      allow(LocationService).to receive(:conn).and_return(Faraday.new(url: 'https://www.mapquestapi.com'))

      stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=#{origin}&to=#{destination}")
        .to_return(status: 200, body: successful_response.to_json, headers: { 'Content-Type' => 'application/json' })

      result = LocationService.get_route(origin, destination)

      expect(result).to eq('02:30:00')
      expect(WebMock).to have_requested(:get, "https://www.mapquestapi.com/directions/v2/route?from=#{origin}&to=#{destination}")
    end

    it 'returns "impossible route" if route is not found' do
      origin = 'New York, NY'
      destination = 'London, UK'
      failed_response = {
        info: { statuscode: 1 },
        route: {}
      }
      allow(LocationService).to receive(:conn).and_return(Faraday.new(url: 'https://www.mapquestapi.com'))

      stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?from=#{origin}&to=#{destination}")
        .to_return(status: 200, body: failed_response.to_json, headers: { 'Content-Type' => 'application/json' })

      result = LocationService.get_route(origin, destination)

      expect(result).to eq('impossible route')
      expect(WebMock).to have_requested(:get, "https://www.mapquestapi.com/directions/v2/route?from=#{origin}&to=#{destination}")
    end
  end
end
