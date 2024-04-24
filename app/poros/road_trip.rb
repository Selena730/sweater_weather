class RoadTrip
    attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

    def initialize(origin, destination, travel_time, weather_data)
        @id = nil
        @start_city = origin
        @end_city = destination
        @travel_time = format_time(travel_time)
        @weather_at_eta = format_weather_at_eta(weather_data)
    end

    def temperature
        @weather_at_eta[:temperature] if @weather_at_eta
    end

    def format_time(time)
        return 'impossible route' if time.nil? || !time.is_a?(Hash)
        
        formatted_time = time[:directions][:route][:formattedTime]
        formatted_time.nil? ? 'impossible route' : formatted_time
    end
      
    def format_weather_at_eta(weather_data)
        eta_weather = weather_data[:forecast].find { |forecast| forecast[:date] == calculate_eta_date }
    
        if eta_weather && eta_weather[:day] && eta_weather[:day][:avgtemp_f]
          {
            temperature: eta_weather[:day][:avgtemp_f],
            condition: eta_weather[:day][:condition][:text]
          }
        else
          { temperature: nil, condition: 'Unknown' }
        end
    end

    ## Time.now + seconds
    def calculate_eta_date
        (Time.now + calculate_travel_time_seconds).strftime('%Y-%m-%d')
    end

    def calculate_travel_time_seconds
        hours, minutes = @travel_time.scan(/\d+/)
        (hours.to_i * 3600) + (minutes.to_i * 60)
    end
end
