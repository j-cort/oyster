class Journey_log
  attr_reader :journey
  
  def initialize(journey = Journey.new("station"))
    @log = [] 
    @journey = journey
  end 

end