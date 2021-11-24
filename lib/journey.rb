# starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.

class Journey
  attr_reader :entry_station, :exit_station, :fare, :completed
  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare
    @completed = false
   end

  def set_exit_station(station)
    @exit_station = station
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