# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:email) }
        it { should validate_uniqueness_of(:email) }
        it { should have_secure_password }


        it 'is invalid without an email' do
          user = build(:user, email: nil)
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include("can't be blank")
        end


        it 'is invalid with a duplicate email' do
          create(:user, email: 'user@example.com')
          user = build(:user, email: 'user@example.com')
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include("has already been taken")
        end

        it 'generates a unique API key on create' do
          user = create(:user)
          expect(user.api_key).not_to be_nil
          expect(user.api_key.length).to eq(26) 
        end
    end
end
