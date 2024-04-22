# spec/services/book_facade_spec.rb
require 'rails_helper'

RSpec.describe BookFacade do
  describe ".book_search" do
        it "returns a list of books" do
            allow(BooksSearchService).to receive(:get_book).and_return({
                docs: [
                { isbn: ['123456789'], title: 'Test Book', publisher: ['Test Publisher'] }
                ],
                numFound: 1
            })

            books = BookFacade.book_search('Denver, CO')
            expect(books.size).to eq(1)
            expect(books.first.title).to eq('Test Book')
        end
    end

  describe ".count_books" do
        it "returns the count of books" do
            allow(BooksSearchService).to receive(:get_book).and_return({ numFound: 10 })
            count = BookFacade.count_books('Denver, CO')
            expect(count).to eq(10)
        end
    end
end
