require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe '.create_road_trip' do
    it 'creates a RoadTrip with the correct data' do
      origin = 'Denver, CO'
      destination = 'Boulder, CO'
      route = { route: { formattedTime: '00:45:23' } }
      weather_at_eta = {
        current_weather: {
          temperature: 55.3,
          condition: 'Partly cloudy'
        }
      }

      allow(LocationService).to receive(:get_route).and_return(route)
      allow(LocationService).to receive(:coordinates).with(destination).and_return('39.7392,-104.9903')
      allow(WeatherService).to receive(:fetch_weather).and_return(weather_at_eta)

      road_trip = RoadTripFacade.create_road_trip(origin, destination)

      expect(road_trip.start_city).to eq(origin)
      expect(road_trip.end_city).to eq(destination)
      expect(road_trip.travel_time).to eq('00:45:23')
      expect(road_trip.temperature).to eq(55.3)
      expect(road_trip.conditions).to eq('Partly cloudy')
    end
  

    describe '.create_road_trip' do # impossible route
      let(:origin) { 'New York, NY' }
      let(:destination) { 'London, UK' }
      let(:route) { nil }
  
      before do
        allow(LocationService).to receive(:get_route).and_return(route)
      end
  
      it 'creates a RoadTrip indicating an impossible route', vcr: { cassette_name: 'impossible_route' } do
        road_trip = RoadTripFacade.create_road_trip(origin, destination)
  
        expect(road_trip.travel_time).to eq('impossible route')
        expect(road_trip.temperature).to be_nil
        expect(road_trip.conditions).to be_nil
      end
    end
  end
end
