require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  describe "GET /books/search" do
    describe "has valid parameters" do
      before do
        allow(BookFacade).to receive(:book_search).and_return([mocked_book] * 5)
        allow(BookFacade).to receive(:count_books).and_return(5)
        allow(ForecastFacade).to receive(:format_current_weather).and_return({ temp: '70 f', condition: 'Sunny' })
      end

      let(:mocked_book) { instance_double(Book, isbn: ['123456789'], title: 'Book', publisher: ['Publisher']) }

      it "returns http success" do
        get '/api/v1/books/search', params: { location: 'Denver, CO', quantity: 5 }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['total_books']).to eq(5)
      end
    end

    describe "has invalid parameters" do
      it "returns http bad request" do
        get '/api/v1/books/search' 
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
