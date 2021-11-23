class Oyster
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :in_use
  attr_reader :entry_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
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
    @entry_station = station
    @journeys.push({ entry: station })

  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @entry_station = nil
    @journeys.last[:exit] = station
  end

  def in_journey?
    @entry_station ? true : false
  end
  
  private 

  def deduct(fare)
    @balance -= fare
  end

end

# card.top(5)
# card.touch_in(streatham)
# => @entry_station = "streatham"
# =>  @journeys.push({entry: streatham})
# card.touch_out(aldgate)
# => @journeys.last[:exit] = station



#  @journeys = [{hash}]
# {entry: "streatham", exit: "aldgate"}