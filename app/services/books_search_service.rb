class BooksSearchService
    def self.conn
      Faraday.new(url: "https://openlibrary.org")
    end
  
    def self.get_book(title)
      response = conn.get('search.json') do |req|
        req.params['q'] = title
      end
      JSON.parse(response.body, symbolize_names: true)
    end
end