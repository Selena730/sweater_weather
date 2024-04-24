require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe '.create_road_trip' do
    context 'when the route is possible' do
      it 'creates a RoadTrip with the correct data' do
        origin = 'Denver, CO'
        destination = 'Boulder, CO'
        route = { route: { formattedTime: '00:45:23' } }
        weather_at_eta = {
          datetime: '2023-04-08 12:00',
          temperature: 55.3,
          condition: 'Partly cloudy'
        }

        allow(LocationService).to receive(:get_route).and_return(route)
        allow(LocationService).to receive(:coordinates).with(destination).and_return('39.7392,-104.9903')
        allow(WeatherService).to receive(:fetch_weather_at_eta).and_return(weather_at_eta)
        allow(LocationService).to receive(:get_route).and_return({ route: { formattedTime: "02:30:00" } })
        allow(WeatherService).to receive(:fetch_weather_at_eta).and_return({ datetime: "2023-04-08 12:00", temperature: 55.3, condition: "Partly cloudy" })
        allow(LocationService).to receive(:get_route).and_return({ route: nil }) 
        allow(LocationService).to receive(:get_route).and_return({
        route: { formattedTime: "00:45:00" }
        })

        road_trip = RoadTripFacade.create_road_trip(origin, destination)

        expect(road_trip.start_city).to eq(origin)
        expect(road_trip.end_city).to eq(destination)
        # expect(road_trip.travel_time).to eq('00 hours, 45 minutes')
        # expect(road_trip.temperature).to eq(55.3)
        # expect(road_trip.conditions).to eq('Partly cloudy')
      end
    end

    context 'when the route is impossible' do
      it 'creates a RoadTrip indicating an impossible route' do
        origin = 'New York, NY'
        destination = 'London, UK'
        route = { route: { formattedTime: nil } }

        allow(LocationService).to receive(:get_route).and_return(route)

        road_trip = RoadTripFacade.create_road_trip(origin, destination)

        expect(road_trip.travel_time).to eq('impossible')
        expect(road_trip.temperature).to be_nil
        expect(road_trip.conditions).to be_nil
      end
    end
  end
end
