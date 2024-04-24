class RoadTrip
    attr_reader :id, :start_city, :end_city, :travel_time, :temperature, :conditions

    def initialize(origin, destination, weather_info, directions_info)
        @id = nil
        @start_city = origin
        @end_city = destination

        # Set travel time based on availability of formattedTime
        @travel_time = if directions_info && directions_info[:route] && directions_info[:route][:formattedTime]
            format_time(directions_info[:route][:formattedTime])
        else
            'impossible'
        end

        # make sure is hash and has keys
        @temperature = weather_info.is_a?(Hash) ? weather_info[:temperature] : nil
        @conditions = weather_info.is_a?(Hash) ? weather_info[:condition] : nil
    end

    private

    def format_time(time)
        hours, minutes, _ = time.split(':')
        "#{hours} hours, #{minutes} minutes"
    end
end
