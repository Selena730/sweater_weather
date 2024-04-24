class LocationService
    def self.conn
      Faraday.new(url: "https://www.mapquestapi.com/geocoding") do |faraday|
        faraday.params["key"] = Rails.application.credentials.mapquest[:key]
      end
    end

    def self.get_url(url)
        response = conn.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end

    def self.coordinates(location)
        data = get_url("v1/address?location=#{location}")
        data[:results].first[:locations].first[:latLng]
    end

    def self.get_route(origin, destination)
        url = "/directions/v2/route?from=#{origin}&to=#{destination}"
        response = conn.get(url)
        return "impossible route" unless response.success?
    
        route_data = JSON.parse(response.body, symbolize_names: true)
        if route_data[:info][:statuscode] == 0
          route_data[:route][:formattedTime] 
        else
          "impossible route"
        end
    end
end