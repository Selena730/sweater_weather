class Api::V1::BooksController < ApplicationController
  def search
    if valid_params?(params[:location], params[:quantity].to_i)
      current_forecast = ForecastFacade.format_current_weather(params[:location])
      books = BookFacade.book_search(params[:location])[0, params[:quantity].to_i]
      count = BookFacade.count_books(params[:location])

      render json: BookSerializer.format_json(current_forecast, params[:location], params[:quantity], books, count)
    else
      render json: { error: { details: "Bad request" } }, status: :bad_request
    end
  end

  private

  def valid_params?(location, quantity)
    location.present? && quantity.positive?
  end
end
