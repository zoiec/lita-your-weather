require "spec_helper"

describe Lita::Handlers::YourWeather, lita_handler: true do
  it { is_expected.to route("weather c") }
  it { is_expected.to route("weather c 90210") }
  it { is_expected.to route_command("weather c") }

  it "route weather f to correct method" do
    is_expected.to route("weather c").to(:weather_current)
  end

  it { is_expected.to route("weather f") }
  it { is_expected.to route("weather f 90210") }
  it { is_expected.to route_command("weather f") }

  it "route weather f to correct method" do
    is_expected.to route("weather f").to(:weather_forecast)
  end
end
