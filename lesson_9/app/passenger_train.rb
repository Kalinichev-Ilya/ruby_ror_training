require_relative 'train'

# Passenger train entity
class PassengerTrain < Train
  @trains = {}
  
  def initialize(number)
    super(number)
  end
end
