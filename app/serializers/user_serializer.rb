class UserSerializer
    include JSONAPI::Serializer
    attributes :email, :api_key

    set_type :users
    set_id :id
end