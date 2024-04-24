class WeatherService
    def self.connection
      Faraday.new(url: "http://api.weatherapi.com/") do |faraday|
        faraday.params["key"] = Rails.application.credentials.weather["key"]
      end
    end
  
    def self.get_url(uri)
      response = connection.get(uri)
      
      JSON.parse(response.body, symbolize_names: true)
    end
  
    def self.fetch_weather(coordinates)
      data = get_url("v1/forecast.json?q=#{coordinates}&days=6")
      
      { 
        current: data[:current], 
        forecast: data[:forecast][:forecastday] 
      }
    end

    def self.fetch_weather_at_eta(coordinates, travel_time)
        weather = fetch_weather(coordinates)
        {
            datetime: Time.now.strftime("%Y-%m-%d %H:%M"),
            temperature: weather[:current][:temp_c],
            condition: weather[:current][:condition][:text]
        }
    end
end