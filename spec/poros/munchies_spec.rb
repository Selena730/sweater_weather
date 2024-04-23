require 'rails_helper'

RSpec.describe Munchies do
  describe '#initialize' do
    let(:weather_data) do
      {
        current: {
          condition: "Clear",
          temp_f: 78.8
        }
      }
    end

    let(:restaurant_data) do
      {
        name: "Giovanni's Pizzeria",
        location: {
          display_address: ["1234 Pizza Street", "Pueblo, CO"]
        },
        rating: 4.5,
        review_count: 150
      }
    end

    subject(:munchies) { described_class.new(weather_data, restaurant_data) }

    it 'initializes with weather data' do
      expect(munchies.weather[:summary]).to eq("Clear")
      expect(munchies.weather[:temperature]).to eq("78.8 F")
    end

    it 'initializes with restaurant data' do
      expected_address = "1234 Pizza Street, Pueblo, CO"
      expect(munchies.restaurant[:name]).to eq("Giovanni's Pizzeria")
      expect(munchies.restaurant[:address]).to eq(expected_address)
      expect(munchies.restaurant[:rating]).to eq(4.5)
      expect(munchies.restaurant[:reviews]).to eq(150)
    end
  end
end
  