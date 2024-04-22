require 'rails_helper'

RSpec.describe Book do
    describe 'initialization' do
        let(:book_data) { { isbn: ['1234567890'], title: 'Any Book', publisher: ['Any Publisher'] } }
        let(:book) { Book.new(book_data) }

        it 'initializes with isbn, title, and publisher' do
            expect(book.isbn).to eq(['1234567890'])
            expect(book.title).to eq('Any Book')
            expect(book.publisher).to eq(['Any Publisher'])
        end
    end 
end