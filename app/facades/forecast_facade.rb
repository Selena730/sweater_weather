class ForecastFacade
  def self.forecast(location)
    coordinates = LocationService.coordinates(location)
    coords_string = "#{coordinates[:lat]},#{coordinates[:lng]}"
    weather_data = WeatherService.fetch_weather(coords_string)

    forecast_data = {
      "current_weather" => format_current_weather(weather_data[:current]),
      "daily_weather" => format_daily_weather(weather_data[:forecast].take(5)),
      "hourly_weather" => format_hourly_weather(weather_data[:forecast].first[:hour])
    }

    Forecast.new(forecast_data)
  end

  private

  def self.format_current_weather(current)
    {
      last_updated: Time.at(current[:last_updated_epoch]).strftime("%Y-%m-%d %H:%M"),
      temperature: current[:temp_f],
      feels_like: current[:feelslike_f],
      humidity: current[:humidity],
      uvi: current[:uv],
      visibility: current[:vis_miles],
      condition: current[:condition][:text],
      icon: current[:condition][:icon]
    }
  end

  def self.format_daily_weather(days)
    days.map do |day|
      {
        date: day[:date],
        sunrise: Time.parse(day[:astro][:sunrise]).strftime("%I:%M %p"),
        sunset: Time.parse(day[:astro][:sunset]).strftime("%I:%M %p"),
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def self.format_hourly_weather(hours)
    hours.map do |hour|
      {
        time: Time.at(hour[:time_epoch]).strftime("%H:%M"),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
  