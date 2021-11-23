require 'station'

describe Station do
  it "creates an instance with name and zone attributes" do
    station = Station.new("Bank", 1)
    expect(station).to have_attributes(:name => "Bank", :zone => 1)
  end
end