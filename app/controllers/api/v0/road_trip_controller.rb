class Api::V0::RoadTripController < ApplicationController
    def create
        user = User.find_by(api_key: params[:api_key])

        # binding.pry
        if user
            road_trip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
            render json: RoadTripSerializer.format_data(road_trip)
        else
            render json: { error: "Unauthorized" }, status: :unauthorized 
        end
    end
end