class RoadTripFacade 
    def self.create_road_trip(origin, destination)
        route = LocationService.get_route(origin, destination)
        if route && route[:route] && route[:route][:formattedTime]
            travel_time = route[:route][:formattedTime]
        else
            travel_time = "impossible route"
        end
        weather_at_eta = if travel_time == "impossible route"
                            { temperature: nil, condition: nil }
                        else
                            coordinates = LocationService.coordinates(destination)
                            eta_weather = WeatherService.fetch_weather_at_eta(coordinates, travel_time)
                            {
                            datetime: eta_weather[:datetime],
                            temperature: eta_weather[:temperature],
                            condition: eta_weather[:condition]
                            }
                        end
        RoadTrip.new(origin, destination, travel_time, weather_at_eta)
    end
end