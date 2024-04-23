class Munchies
  attr_reader :weather, :restaurant, :destination_city
  

  def initialize(weather_data, restaurant_data)
    @destination_city = restaurant_data[:location][:city]
    # binding.pry
    @weather = {
      summary: weather_data.current_weather[:condition],
      temperature: "#{weather_data.current_weather[:temp_f]} F"
    }
    @restaurant = {
      name: restaurant_data[:name],
      address: restaurant_data[:location][:display_address].join(", "),
      rating: restaurant_data[:rating],
      reviews: restaurant_data[:review_count]
    }
  end
end