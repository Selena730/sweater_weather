require 'rails_helper'

RSpec.describe 'Users API' do
  describe "POST /api/v0/users" do
        it "has valid params" do
            expect {
                post "/api/v0/users", params: {
                "email": "user@example.com",
                "password": "password123",
                "password_confirmation": "password123"
            }}.to change(User, :count).by(1)

            expect(response).to be_successful

            json = JSON.parse(response.body)

            expect(json["data"]["attributes"]["email"]).to eq("user@example.com")
        end

        it "does not create a new user and returns an error" do
            expect {
              post "/api/v0/users", params: {
                user: {
                  email: "", 
                  password: "password123",
                  password_confirmation: "password123"
                }
              }, as: :json
            }.not_to change(User, :count)
    
            expect(response).to have_http_status(:unprocessable_entity)
    
            json = JSON.parse(response.body)
            expect(json).to have_key('errors')
            expect(json['errors']).to include("Email can't be blank")
        end
    end
end