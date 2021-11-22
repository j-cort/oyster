class Oyster
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT
  end

  def enough_balance?
    @balance >= MIN_BALANCE
  end

  def top_up(amount)
    raise "This top up would exceed your £#{LIMIT} card limit." if exceed_limit?(amount)
    @balance += amount
  end
  
  private 

  def deduct(fare)
    @balance -= fare
  end
  
  public

  def touch_in
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
    @in_use = true
  end

  def touch_out
    @in_use = false
    deduct(MIN_BALANCE)
  end

  def in_journey?
    @in_use
  end

end