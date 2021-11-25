require 'journey'

class JourneyLog
  FARE = 1
  PENALTY_FARE = 6
  attr_reader :journey
  
  def initialize(journey = Journey.new("station"))
    @log = [] 
    @journey = journey
  end 

  def start(station_a)
    @journey.set_entry_station(station_a)
  end
  
  def finish(station_b)
    @journey.set_exit_station(station_b)

    if @journey.entry_station == nil || @journey.exit_station == nil 
        set_fare(PENALTY_FARE)
      else 
        set_fare(FARE)
      end
      @journey.finish
  end

  def add_to_log(journey)
    @log << journey
  end 

private 
  def current_journey
    @journey
  end

end