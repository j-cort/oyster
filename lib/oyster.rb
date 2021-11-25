require_relative 'journey'

class Oyster
  JourneyLog::FARE = 1
  JourneyLog::PENALTY_FARE = 6
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
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

  def touch_in(station_a)
    
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
  
    !in_journey? ? touch_in_complete(station_a) : touch_in_incomplete(station_a) 
  end

  def touch_in_complete(station_a) 
    @journey_log.start(station_a)
  end
  
  def touch_in_incomplete(station_b)
    deduct(JourneyLog::PENALTY_FARE) 
    @journey_log.finish(nil)
    add_to_log(@journey_log)
    @journey_log.start(station_b)
  end

  def touch_out(station)
    in_journey? ? touch_out_complete(station_b) : touch_out_incomplete(station_b)
  end

  def in_journey?
    @journey_log.finished ? false : true
  end

  def touch_out_complete(station_b)
    deduct(JourneyLog::FARE)
     @journey_log.finish(station_b)
     @journey_log.add_to_log(@journey_log)
  end

  def touch_out_incomplete(station_b)
    @journey_log.start(nil)
    deduct(JourneyLog::PENALTY_FARE) 
    @journey_log.finish(station_b)
    @journey_log.add_to_log(@journey_log)
  end
  
  private

  def deduct(fare)
    @balance -= fare
  end

end
