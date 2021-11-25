require 'journey'

class JourneyLog

  FARE = 1
  PENALTY_FARE = 6
  attr_reader :journey, :log, :current_journey
  
  def initialize(journey = Journey.new("station"))
    @log = [] 
    @current_journey = journey
  end 

  def start(station_a)
    @current_journey.set_entry_station(station_a)
  end
  
  def finish_trip(station_b)
    @current_journey.set_exit_station(station_b)

    if @current_journey.entry_station == nil || @current_journey.exit_station == nil 
        set_fare(PENALTY_FARE)
      else 
        set_fare(FARE)
      end
      @current_journey.completed
  end

  def add_to_log(journey)
    @log << journey
  end 

private 
  def what_journey
    @current_journey
  end

end