require_relative 'journey'

class Oyster
  # FARE = 1
  PENALTY_FARE = 6
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize
    @balance = 0
    @entry_station = nil # remove
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
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
    # @entry_station = station # remove
    # @journeys.push({ entry_station: station }) #remove
    if !in_journey?
      @current_journey = Journey.new(station)
    else
      deduct(PENALTY_FARE)
      @current_journey.exit_station(nil)
      @journeys << @current_journey
      @current_journey = Journey.new(entry_station)
    end
  end

  def touch_out(station)
    # if in_journey?
    deduct(MIN_BALANCE)
      # deduct(FARE)
      # current_journey.exit_station(station)
      # current_journey.completed
      # @journeys << current_journey
      # current_journey = nil 
    # else
      # current_journey = Journey.new(nil)
      # deduct(PENALTY_FARE)
      # current_journey.exit_station(station)
      # @journeys << current_journey
      # current_journey = nil 
    @entry_station = nil
    @journeys.last[:exit] = station
  end

  def in_journey?
    @current_journey ? true : false
  end
  
  private 

  def deduct(fare)
    @balance -= fare
    @current_journey.set_fare(fare)
  end

end
