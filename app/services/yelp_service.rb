class YelpService
    def self.conn
        Faraday.new(url: "https://api.yelp.com/v3/businesses/") do |faraday|
            faraday.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp[:key]}"
        end
    end
    
    def self.get_url(url)
        response = conn.get(url)
        JSON.parse(response.body, symbolize_names: true)
    end

    def self.get_resto(location, food_type)
        url = "search?location=#{location}&categories=#{food_type}&sort_by=rating&limit=1"
        response = get_url(url)
        response[:businesses].first
    end
end