require 'oyster'

describe Oyster do
  it "return a default balance of 0" do
    card = Oyster.new
    expect(card.balance).to eq 0
  end
end