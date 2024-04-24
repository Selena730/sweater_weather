class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    before_create :generate_api_key #callback .. only before creation. So only for new objects (create action)

  

    def generate_api_key
      self.api_key = SecureRandom.hex(13) 
    end
  end
