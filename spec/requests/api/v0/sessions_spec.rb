require 'rails_helper'


RSpec.describe 'Sessions API' do
    describe "POST  /api/v0/sessions" do
        it "returns JSON data for user" do
            user = User.create(email: "user@example.com", password: "password123")
    
            post "/api/v0/sessions", params: {
            "email": "user@example.com",
            "password": "password123"
            }
    
            expect(response).to be_successful
            expect(response).to have_http_status(:ok)

            json_response = JSON.parse(response.body)
            expect(json_response['data']).not_to be_empty
            expect(json_response['data']['type']).to eq('users')
            expect(json_response['data']['id']).to eq(user.id.to_s)
            expect(json_response['data']['attributes']['email']).to eq('user@example.com')
            api_key = json_response['data']['attributes']['api_key']
            expect(api_key).not_to be_nil
            # expect(api_key).to match("f9cfb6333f68ff850c90e6b70241ba531c100aab08f7bc398117") Keeps changing 
        end

        it 'returns nil for invalid' do 
            user = User.create(email: " ", password: "password123")
    
            post "/api/v0/sessions", params: {
            "email": " ",
            "password": "password123"
            }
    
            expect(response).to_not be_successful
            expect(response).to have_http_status(:unauthorized)

            json_response = JSON.parse(response.body)
            expect(json_response['data']).to eq(nil)
        end
    end
end