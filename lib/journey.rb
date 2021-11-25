# starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.
require 'journey_log'

class Journey
  attr_reader :entry_station, :exit_station, :fare, :completed
  
  def initialize(entry_station = nil)
    @entry_station = nil
    @exit_station = nil
    @fare
    @completed = false
   end

  def set_entry_station(station_a)
    @entry_station = station_a
  end

  def set_exit_station(station_b)
    @exit_station = station_b
  end

 

  def set_fare(fare)
    @fare = fare
  end
  
  def complete
    @completed = true
  end



end




# def fare
#     return FARE unless !@entry_station || !@exit_station
#     PENALTY_FARE
#   end