require 'rails_helper'

RSpec.describe YelpService, type: :service do
  describe 'Yelp Service instance methods', :vcr do
    it '#conn, returns a Faraday object' do
      expect(YelpService.conn).to be_a(Faraday::Connection)
    end

    it '#get_resto, returns single top rated by location and food type' do
      location = 'pueblo,co'
      food = 'italian'
      restaurant = YelpService.get_resto(location, food)

      expect(restaurant).to be_a(Hash)
      expect(restaurant).to have_key(:name)
      expect(restaurant[:name]).to be_a(String)
      expect(restaurant).to have_key(:location)
      expect(restaurant[:location]).to be_a(Hash)
      expect(restaurant[:location]).to have_key(:display_address)
      expect(restaurant[:location][:display_address]).to be_a(Array)
      expect(restaurant).to have_key(:review_count)
      expect(restaurant[:review_count]).to be_a(Integer)
      expect(restaurant).to have_key(:rating)
      expect(restaurant[:rating]).to be_a(Float)
    end
  end
end
