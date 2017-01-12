require "spec_helper"

describe Lita::Handlers::YourWeather, lita_handler: true do

  it "route weather to correct method" do
    is_expected.to route("weather").to(:weather_current)
  end

  it "route weather f to correct method" do
    is_expected.to route("weather c").to(:weather_current)
  end

  it "route weather f to correct method" do
    is_expected.to route("weather f").to(:weather_forecast)
  end
end
