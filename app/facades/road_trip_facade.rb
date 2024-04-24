class RoadTripFacade
   
    def self.create_road_trip(origin, destination)
        travel_time = LocationService.get_route(origin, destination)
        weather_at_eta = fetch_weather_at_eta(destination) 
    
        RoadTrip.new(origin, destination, travel_time, weather_at_eta)
    end
    
      
    private
  
    def self.fetch_weather_at_eta(destination)
      coordinates = LocationService.coordinates(destination)
      WeatherService.fetch_weather(coordinates)
    end
end
  