require 'journey'

class JourneyLog
  attr_reader :journey
  
  def initialize(journey = Journey.new("station"))
    @log = [] 
    @journey = journey
  end 

  def start()
    @journey.entry_station
  end

private 
  def current_journey
    @journey
  end

end