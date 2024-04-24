require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe '.create_road_trip' do
    let(:origin) { 'Denver, CO' }
    let(:destination) { 'Boulder, CO' }
    let(:travel_time) { '00:45:23' }
    let(:weather_data) do
      {
        forecast: [
          { date: '2024-04-25', day: { avgtemp_f: 60, condition: { text: 'Partly cloudy' } } },
          { date: '2024-04-26', day: { avgtemp_f: 65, condition: { text: 'Sunny' } } }
        ]
      }
    end

    before do
      allow(LocationService).to receive(:get_route).with(origin, destination).and_return(travel_time)
      allow(WeatherService).to receive(:fetch_weather).and_return(weather_data)

    end

    it 'creates a RoadTrip with the correct data' do
      VCR.use_cassette('location_service/coordinates') do
        road_trip = RoadTripFacade.create_road_trip(origin, destination)

        expect(road_trip.start_city).to eq(origin)
        expect(road_trip.end_city).to eq(destination)
        expect(road_trip.travel_time).to eq('00 hours, 45 minutes')
        expect(road_trip.weather_at_eta).to eq({ temperature: 60, condition: 'Partly cloudy' })
      end
    end
  end
end
