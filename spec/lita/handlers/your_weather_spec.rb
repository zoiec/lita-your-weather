require "spec_helper"

describe Lita::Handlers::YourWeather, lita_handler: true do

  it "will route lita weather to the weather method" do
    is_expected.to route("lita weather").to(:weather)
  end

  it "will route lita weather c to the weather method" do
    is_expected.to route("lita weather c").to(:weather)
  end

  it "will route lita weather f to the weather method" do
    is_expected.to route("lita weather f").to(:weather)
  end

  it "will route lita weather i to the weather method" do
    is_expected.to route("lita weather i").to(:weather)
  end

  it "will not route weather" do
    is_expected.to_not route("weather")
  end

  it "will not route weather c" do
    is_expected.to_not route("weather c")
  end

  it "will not route weather f" do
    is_expected.to_not route("weather f")
  end
end
