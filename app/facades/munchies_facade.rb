class MunchiesFacade
  def self.munchies(destination, food_type)
    forecast_data = ForecastFacade.forecast(destination)
    restaurant_data = YelpService.get_resto(destination, food_type)

    munchie = Munchies.new(forecast_data, restaurant_data)
  end
end
  