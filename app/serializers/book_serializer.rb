class BookSerializer
    def self.format_json(forecast, location, quantity, books, total_books)
      {
        forecast: forecast,
        location: location,
        quantity: quantity,
        total_books: total_books,
        books: books.map do |book|
          {
            isbn: book.isbn,
            title: book.title,
            publisher: book.publisher.join(", ")
          }
        end
      }
    end
end