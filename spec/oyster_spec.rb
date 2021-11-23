require 'oyster'

describe Oyster do
  let(:card) { described_class.new }
  let(:station) { double('station') }

  it "return a default balance of 0" do
    expect(card.balance).to eq 0
  end

  it "allows user to top up card" do
    expect(card).to respond_to(:top_up).with(1).argument
  end

  it "balance increases by a specified amount when user tops up" do
    expect{ card.top_up 1 }.to change{ card.balance }.by 1
  end

  it "does not allow user to top  up card beyond maximum balance" do
    expect{ card.top_up(Oyster::LIMIT + 1) }.to raise_error "This top up would exceed your £#{Oyster::LIMIT} card limit."
  end

  it "set in_use to be true when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect(card).to be_in_journey
  end

  it "set in_use to be false when touch out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    card.touch_out
    expect(card).not_to be_in_journey
  end

  it "in_journey return true when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect(card.in_journey?).to eq true
  end

  it "in_journey return false when touch_in and touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    card.touch_out
    expect(card.in_journey?).to eq false
  end

  it "does not allow user to touch in if card is under the minimum balance" do
    expect { card.touch_in(station) }.to raise_error "You have less than the £#{Oyster::MIN_BALANCE} minimum balance, please top up."
  end

  it "deducts the mimimum fare after touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect { card.touch_out }.to change{card.balance}.by(-Oyster::MIN_BALANCE)
  end

  it "update @entry_station when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    expect { card.touch_in(station) }.to change { card.entry_station }.from(nil).to(station)
  end

  it "update @entry_station to nil when touch out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect { card.touch_out }.to change { card.entry_station }.from(station).to(nil)
  end
end

# def touch_in(station)
  # some code
  # @entry_station = station
# end