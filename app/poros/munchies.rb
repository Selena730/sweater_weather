class Munchies
  attr_reader :weather, :restaurant

  def initialize(weather_data, restaurant_data)
    @weather = {
      summary: weather_data[:current][:condition],
      temperature: "#{weather_data[:current][:temp_f]} F"
    }
    @restaurant = {
      name: restaurant_data[:name],
      address: restaurant_data[:location][:display_address].join(", "),
      rating: restaurant_data[:rating],
      reviews: restaurant_data[:review_count]
    }
  end
end