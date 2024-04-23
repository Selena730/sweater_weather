require 'rails_helper'

RSpec.describe MunchiesFacade do
  describe '.munchies', :vcr do
    it 'fetches and combines weather and restaurant data' do
      destination_param = 'pueblo,co'
      food_param = 'italian'
      
      munchie = MunchiesFacade.munchies(destination_param, food_param)

      expect(munchie).to be_a(Munchies)

      # expect(munchie).to respond_to(:address)
      # expect(munchie).to respond_to(:destination_city)
      # expect(munchie).to respond_to(:forecast)
      # expect(munchie).to respond_to(:name)
      # expect(munchie).to respond_to(:rating)
      # expect(munchie).to respond_to(:reviews)
    end
  end
end
  