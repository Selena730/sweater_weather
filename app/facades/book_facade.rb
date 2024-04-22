class BookFacade
    def self.book_search(location)
        book_data = BooksSearchService.get_book(location)
        book_data[:docs].map { |data| Book.new(data) }
    end
    
    def self.count_books(location)
        BooksSearchService.get_book(location)[:numFound]
    end
end
