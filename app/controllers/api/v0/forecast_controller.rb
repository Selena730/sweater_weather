class Api::V0::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast(params[:location])
    render json: ForecastSerializer.new(forecast), status: :ok
  end
end