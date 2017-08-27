require_relative 'wagon'
require_relative 'passenger_train'

# Passenger wagon entity
class PassengerWagon < Wagon
  def initialize(capacity)
    super
    @type = PassengerTrain
  end
end
