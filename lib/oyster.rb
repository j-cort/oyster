require_relative 'journey'

class Oyster
  FARE = 1
  PENALTY_FARE = 6
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize()#journey_log = JourneyLog.new
    @balance = 0
    # @journey_log = journey_log
    @journeys = []
    @current_journey = nil
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
    # @journey_log.start
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
  
    !in_journey? ? touch_in_complete(station) : touch_in_incomplete(station) 
  end

  def touch_in_complete(station)
    @current_journey = Journey.new
    @current_journey.set_entry_station(station)
  end
  
  def touch_in_incomplete(station)
    deduct(PENALTY_FARE)
    @current_journey.set_exit_station(nil)
    @journeys << @current_journey
    @current_journey = Journey.new
    @current_journey.set_entry_station(station)
  end

  def touch_out(station)
    in_journey? ? touch_out_complete(station) : touch_out_incomplete(station)
  end

  def in_journey?
    @current_journey ? true : false
  end

  def touch_out_complete(station)
    deduct(FARE)
    @current_journey.set_exit_station(station)
    @current_journey.complete
    @journeys << current_journey
    @current_journey = nil 
  end

  def touch_out_incomplete(station)
    @current_journey = Journey.new
    deduct(PENALTY_FARE)
    @current_journey.set_exit_station(station)
    @journeys << current_journey
    @current_journey = nil 
  end
  
  private

  def deduct(fare)
    @balance -= fare
    @current_journey.set_fare(fare)
  end

end
