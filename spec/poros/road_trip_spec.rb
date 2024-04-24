require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialize' do
    it 'initializes a RoadTrip object with correct attributes' do
      weather_info = { temperature: 44.2, conditions: 'Cloudy with a chance of meatballs' }
      directions_info = { route: { formattedTime: '04:40:45' } }

      road_trip = RoadTrip.new(
        'New York, NY',
        'Los Angeles, CA',
        weather_info,
        directions_info
      )

      expect(road_trip.start_city).to eq('New York, NY')
      expect(road_trip.end_city).to eq('Los Angeles, CA')
      expect(road_trip.travel_time).to eq('04 hours, 40 minutes')
      expect(road_trip.temperature).to eq(44.2)
      expect(road_trip.conditions).to eq('Cloudy with a chance of meatballs')
    end
  end
end
