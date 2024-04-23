class Api::V0::SessionsController < ApplicationController
    def create
        # binding.pry
        user = User.find_by(email: params[:email])
    
        if user && user.authenticate(params[:password])
          render json: UserSerializer.new(user), status: :ok
        else
          render json: { errors: ['Invalid email or password'] }, status: 400
        end
    end
end
  