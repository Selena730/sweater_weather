require 'rails_helper'

RSpec.describe Forecast do
  describe '#initialize' do
    it 'creates a new forecast object with correct attributes' do
      data = {
        "id" => nil,
        "current_weather" => {
          "last_updated_epoch" => 1648450507,
          "temp_f" => 50,
          "feelslike_f" => 48,
          "humidity" => 75,
          "uv" => 3,
          "vis_miles" => 10,
          "condition" => { "text" => "Partly cloudy", "icon" => "icon_url" }
        },
        "hourly_weather" => [
          { "time_epoch" => 1648450800, "temp_f" => 50, "condition" => { "text" => "Partly cloudy", "icon" => "icon_url" } }
        ],
        "daily_weather" => [
          { "date" => "2024-04-01", "sunrise" => "06:00", "sunset" => "18:00", "max_temp_f" => 60, "min_temp_f" => 40, "condition" => { "text" => "Sunny", "icon" => "icon_url" } }
        ]
      }

      forecast = Forecast.new(data)

      expect(forecast.id).to be_nil
      expect(forecast.current_weather).to eq({
        "last_updated_epoch" => 1648450507,
        "temp_f" => 50,
        "feelslike_f" => 48,
        "humidity" => 75,
        "uv" => 3,
        "vis_miles" => 10,
        "condition" => { "text" => "Partly cloudy", "icon" => "icon_url" }
      })
      expect(forecast.hourly_weather).to eq([
        { "time_epoch" => 1648450800, "temp_f" => 50, "condition" => { "text" => "Partly cloudy", "icon" => "icon_url" } }
      ])
      expect(forecast.daily_weather).to eq([
        { "date" => "2024-04-01", "sunrise" => "06:00", "sunset" => "18:00", "max_temp_f" => 60, "min_temp_f" => 40, "condition" => { "text" => "Sunny", "icon" => "icon_url" } }
      ])
    end
  end
end
