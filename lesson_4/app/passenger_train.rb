require_relative 'train'

# Passenger train entity
class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type = 'passenger'
  end
end
