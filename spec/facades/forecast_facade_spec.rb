require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  describe '.forecast' do
        it 'returns formatted forecast data when given a valid location', :vcr do
            location = 'Denver, CO'
            forecast = ForecastFacade.forecast(location)

            expect(forecast).to be_a(Forecast)
            expect(forecast.id).to be_nil
            expect(forecast.current_weather).to include(:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon)
            expect(forecast.daily_weather).to be_an(Array)
            expect(forecast.daily_weather.first).to include(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon)
            expect(forecast.hourly_weather).to be_an(Array)
            expect(forecast.hourly_weather.first).to include(:time, :temperature, :conditions, :icon)
        end
        
        it 'raises an error' do
            location = 'Invalid Location'

            expect { ForecastFacade.forecast(location) }.to raise_error(StandardError)
        end
  end
end
