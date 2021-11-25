require 'journey_log'

describe JourneyLog do
  # let(:station) { double('station') }

  # it "creates an instance of journey_log with journeys & journey attribute" do
  #   journey_log = JourneyLog.new()
  #   expect(journey_log).to be_an_instance_of(JourneyLog)
  # end 

  # it "initializes with a new journey in the @journey attribute" do
  #   journey_log = JourneyLog.new()
  #   expect(journey_log.journey).to be_an_instance_of(Journey)
  # end 

  # describe '#start' do
  #   it 'start a new journey with an entry station' do 
  #     journey_log = JourneyLog.new()
  #     journey_log.start
  #     expect(journey_log.journey.set_entry_station("start_station")).to eq "start_station"
  #   end
  # end

  # describe '#current_journey' do
  #   xit 'should return an incomplete journey' do
  #     journey_log = JourneyLog.new()
  #     # oyster = Oyster.new
  #     # oyster.top_up(Oyster::MIN_BALANCE)
  #     # oyster.touch_in("station")
  #     expect(journey_log.current_journey).to eq JourneyLog.journey
  #   end 

  #   xit 'creates a new journey' do 
  #     journey_log = JourneyLog.new()
  #     expect(JourneyLog.current_journey).to be_an_instance_of Journey
  #   end
  # end

end 

# it "creates an instance with name and zone attributes" do
#   station = Station.new("Bank", 1)
#   expect(station).to have_attributes(:name => "Bank", :zone => 1)
# end