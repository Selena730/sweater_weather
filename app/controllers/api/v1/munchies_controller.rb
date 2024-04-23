class Api::V1::MunchiesController < ApplicationController
  def search
    munchie_data = MunchiesFacade.munchies(params[:city], params[:craving])
    render json: MunchieSerializer.new(munchie_data).to_json, status: :ok
  end
end