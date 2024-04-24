class Api::V0::RoadTripController < ApplicationController
    def create
        return render json: { error: "Unauthorized" }, status: :unauthorized unless valid_api_key?

        road_trip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
        render json: RoadTripSerializer.new(road_trip)
      end

      private

      def valid_api_key?
        # binding.pry
        # Ensure that the provided API key matches what's expected
        params[:api_key] == Rails.application.credentials.expected_api_key
    end
end