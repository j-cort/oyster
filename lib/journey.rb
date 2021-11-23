# starting a journey, finishing a journey, calculating the fare of a journey, and returning whether or not the journey is complete.

=begin

class Journey
  attr_reader :FOR EVERYTHING

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @fare
    @completed = false
   end

  def exit_station(station)
    @exit_station = station
  end

  def set_fare(fare)
    @fare = fare
  end
  
  def completed
    @completed = true
  end



end

end=


# def fare
#     return FARE unless !@entry_station || !@exit_station
#     PENALTY_FARE
#   end