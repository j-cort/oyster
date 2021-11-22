require 'oyster'

describe Oyster do
  let(:card) { described_class.new }

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

  # it "reduce the balance by a specified amount" do
  #   card.top_up(5)
  #   result = card.send(:deduct, 1)
  #   expect{ result }.to change{ card.balance }.by -1
  # end

  it "set in_use to be true when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in
    expect(card).to be_in_journey
  end

  it "set in_use to be false when touch out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in
    card.touch_out
    expect(card).not_to be_in_journey
  end

  it "in_journey return true when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in
    expect(card.in_journey?).to eq true
  end

  it "in_journey return false when touch_in and touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in
    card.touch_out
    expect(card.in_journey?).to eq false
  end

  it "does not allow user to touch in if card is under the minimum balance" do
    expect { card.touch_in }.to raise_error "You have less than the £#{Oyster::MIN_BALANCE} minimum balance, please top up."
  end

  it "deducts the mimimum fare after touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in
    expect { card.touch_out }.to change{card.balance}.by(-Oyster::MIN_BALANCE)
  end
end