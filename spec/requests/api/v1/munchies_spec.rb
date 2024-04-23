require 'rails_helper'

RSpec.describe "Mestaurants", type: :request do
  describe "GET /search" do
    it 'returns a successful response, 200, for valid params' do
        munchies_params = { destination: 'pueblo,co', food: 'italian'}
        get '/api/v1/munchies', params: munchies_params
        expect(response.status).to eq(200)
  
        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to have_key(:data)
        expect(data[:data]).to have_key(:id)
        expect(data[:data][:id]).to eq(nil)
        expect(data[:data]).to have_key(:type)
        expect(data[:data][:type]).to eq("munchie")
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to be_a(Hash)
  
        attributes = data[:data][:attributes]
        expect(attributes).to have_key(:destination_city)
        expect(attributes[:destination_city]).to be_a(String)
        expect(attributes).to have_key(:forecast)
        expect(attributes[:forecast]).to be_a(Hash)
        expect(attributes[:forecast]).to have_key(:summary)
        expect(attributes[:forecast][:summary]).to be_a(String)
        expect(attributes[:forecast]).to have_key(:temperature)
        expect(attributes[:forecast][:temperature]).to be_a(String)
  
        restaurant = data[:data][:attributes][:restaurant]
        expect(restaurant).to have_key(:name)
        expect(restaurant[:name]).to be_a(String)
        expect(restaurant).to have_key(:address)
        expect(restaurant[:address]).to be_a(String)
        expect(restaurant).to have_key(:rating)
        expect(restaurant[:rating]).to be_a(Float).or be_a(Integer)
        expect(restaurant).to have_key(:reviews)
        expect(restaurant[:reviews]).to be_a(Integer)
      end  
  end
end
