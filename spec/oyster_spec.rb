require 'oyster'

describe Oyster do
  let(:card) { described_class.new }
  let(:station) { double('station') }
  let(:station_b) { double('station_b') }


  it "return a default balance of 0" do
    expect(card.balance).to eq 0
  end

  it "card has an empty list of journeys by default" do
    expect(card.journeys.empty?).to eq true
  end

  describe "#top_card" do

    it "allows user to top up card" do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it "balance increases by a specified amount when user tops up" do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it "does not allow user to top up card beyond maximum balance" do
      expect{ card.top_up(Oyster::LIMIT + 1) }.to raise_error "This top up would exceed your £#{Oyster::LIMIT} card limit."
    end

  end

  describe "#touch_in" do

    it "set in_use to be true when touch in" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it "does not allow user to touch in if card is under the minimum balance" do
      expect { card.touch_in(station) }.to raise_error "You have less than the £#{Oyster::MIN_BALANCE} minimum balance, please top up."
    end

    it 'check that current journey has been updated' do 
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect(card.current_journey).to be_an_instance_of Journey 
    end

    it 'deducts penalty fare for touching in, without touching out' do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect{ card.touch_in(station) }.to change{ card.balance }.by -(Oyster::PENALTY_FARE)
    end

    it 'changes exit station to nil after touching in, without touching out' do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_in(station)
      expect(card.current_journey.set_exit_station(nil)).to eq nil
    end

    it "checks that journeys logs previous trip after touching in twice" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_in(station_b)
      expect(card.journeys.last.entry_station).to eq station
    end

    it "checks that a new current journey is inialized after touching in twice" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_in(station_b)
      expect(card.current_journey).to be_an_instance_of Journey
    end


    

  end

  describe "#touch_out" do

    it "deducts the mimimum fare after touch_out" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect { card.touch_out(station_b) }.to change{card.balance}.by(-Oyster::MIN_BALANCE)
    end

    it "creates a journey after touch_in and touch_out" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.journeys.count).to eq 1
    end

    it "accurately records the journey entry and exit station" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.journeys.last.entry_station).to eq station
      expect(card.journeys.last.exit_station).to eq station_b
    end

    it 'deducts normal fare after touching out' do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect{ card.touch_out(station) }.to change{ card.balance }.by -(Oyster::FARE)
    end

    it "checks exit station is recorded when you touch out" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.journeys.last.exit_station).to eq station_b
    end

    it "checks journey is completed when you touch out" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.journeys.last.completed).to eq true
    end

    it "checks journey is added to journeys log when you touch out" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.journeys.last.entry_station).to eq station
    end 

    it "checks that current station is set to nil after completing a trip" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station_b)
      expect(card.current_journey).to eq nil
    end

    it "Entry station is set to nil, when touching out without touching in" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_out(station_b)
      expect(card.journeys.last.entry_station).to eq nil
    end

    it "charges penalty fare when touching out without touching in" do
      card.top_up(Oyster::MIN_BALANCE)
      expect{ card.touch_out(station_b) }.to change{ card.balance }.by -(Oyster::PENALTY_FARE)
    end

    it "Check journey is logged in journeys, when touching out without touching in" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_out(station_b)
      expect(card.journeys.last.exit_station).to eq station_b
    end

    it "Checks current journey is reset, after touching out without touching in" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_out(station_b)
      expect(card.current_journey).to eq nil
    end
    

  end

  describe "#in_journey" do

    it "in_journey return true when touch in" do
      card.top_up(Oyster::MIN_BALANCE)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    # it "set in_use to be false when touch out" do
    #   card.top_up(Oyster::MIN_BALANCE)
    #   card.touch_in(station)
    #   card.touch_out(station_b)
    #   expect(card).not_to be_in_journey
    # end

    # it "in_journey return false when touch_in and touch_out" do
    #   card.top_up(Oyster::MIN_BALANCE)
    #   card.touch_in(station)
    #   card.touch_out(station_b)
    #   expect(card.in_journey?).to eq false
    # end
  
  end

 
 



 

  
  

  

  



 

  

 

end



