class Api::V1::MunchiesController < ApplicationController
  def search
    munchie_data = MunchiesFacade.munchies(params[:destination], params[:craving])
    render json: MunchiesSerializer.new(munchie_data).to_json, status: :ok
  end
end