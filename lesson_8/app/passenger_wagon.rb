require_relative 'wagon'
require_relative 'passenger_train'

# Passenger wagon entity
class PassengerWagon < Wagon
  def initialize(capacity)
    super
    @type = PassengerTrain
  end

  def take_a_place
    @occuped_place = [@occuped_place + 1, @capacity].min
  end
end
