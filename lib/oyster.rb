class Oyster
  LIMIT = 90
  attr_reader :balance
  attr_reader :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT
  end

  def top_up(amount)
    raise "This top up would exceed your £#{Oyster::LIMIT} card limit." if exceed_limit?(amount)
    @balance += amount
  end
  
  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end