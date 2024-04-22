require 'rails_helper'

RSpec.describe BooksSearchService, type: :service do
  describe ".get_book" do
    let(:title) { "The Great Gatsby" }
    let(:url) { "https://openlibrary.org/search.json" }
    let(:response_body) do
      {
        docs: [
          {
            title: "The Great Gatsby",
            author_name: ["F. Scott Fitzgerald"],
            isbn: ["9780736692427"],
            publisher: ["Charles Scribner's Sons"]
          }
        ],
        numFound: 1
      }
    end

    before do
      stub_request(:get, url)
        .with(query: { q: title })
        .to_return(status: 200, body: response_body.to_json, headers: {})
    end

    it "fetches book data from open library" do
      result = described_class.get_book(title)
      expect(result[:numFound]).to eq(1)
      expect(result[:docs].first[:title]).to eq("The Great Gatsby")
    end
  end
end
