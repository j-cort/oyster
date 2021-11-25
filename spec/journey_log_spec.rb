require 'journey_log'

describe Journey_log do
  # let(:station) { double('station') }

  it "creates an instance of journey_log with journeys & journey attribute" do
    journey_log = Journey_log.new()
    expect(journey_log).to be_an_instance_of(Journey_log)
  end 

  it "initializes with a new journey in the @journey attribute" do
    journey_log = Journey_log.new()
    expect(journey_log.journey).to be_an_instance_of(Journey)
  end 

end 

# it "creates an instance with name and zone attributes" do
#   station = Station.new("Bank", 1)
#   expect(station).to have_attributes(:name => "Bank", :zone => 1)
# end