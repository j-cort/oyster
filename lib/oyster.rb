class Oyster
  LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT
  end

  def top_up(amount)
    raise "This top up would exceed your £#{Oyster::LIMIT} card limit." if exceed_limit?(amount)
    @balance += amount
  end
  
end