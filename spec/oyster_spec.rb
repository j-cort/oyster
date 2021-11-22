require 'oyster'

describe Oyster do

  it "return a default balance of 0" do
    card = Oyster.new
    expect(card.balance).to eq 0
  end

  it "allows user to top up card" do
    card = Oyster.new
    expect(card).to respond_to(:top_up).with(1).argument
  end

  it "balance increases by the inputted amount when user tops up" do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it "does not allow user to top  up card beyond maximum balance" do
    card = Oyster.new
    expect{ subject.top_up(Oyster::LIMIT + 1) }.to raise_error "This top would exceed your £#{Oyster::LIMIT} card limit."
  end
end