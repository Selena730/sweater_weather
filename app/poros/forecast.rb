class Forecast
  attr_reader :id, :current_weather, :hourly_weather, :daily_weather
  def initialize(data)
    @id = nil
    @current_weather = data["current_weather"]
    @hourly_weather = data["hourly_weather"]
    @daily_weather = data["daily_weather"]
  end
end