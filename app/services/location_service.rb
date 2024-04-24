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
        response = get_url(url)
        return { route: { formattedTime: nil } } unless response[:info][:statuscode] == 0
    
        {
          route: {
            formattedTime: response[:route][:formattedTime]
          }
        }
    end
end