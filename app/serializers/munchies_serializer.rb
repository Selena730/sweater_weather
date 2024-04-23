class MunchiesSerializer
  def initialize(munchie)
    @munchie = munchie
  end

  def to_json
    # binding.pry
    {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: @munchie.destination_city,  
          forecast: {
            summary: @munchie.weather[:summary],
            temperature: @munchie.weather[:temperature]
          },
          restaurant: {
            name: @munchie.restaurant[:name],
            address: @munchie.restaurant[:address],
            rating: @munchie.restaurant[:rating],
            reviews: @munchie.restaurant[:reviews]
          }
        }
      }
    }.to_json  
  end
end
