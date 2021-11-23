class Oyster
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :in_use
  attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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

  def touch_in(station)
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
    @in_use = true
    @entry_station = station
  end

  def touch_out
    @in_use = false
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end
  
  private 

  def deduct(fare)
    @balance -= fare
  end

end