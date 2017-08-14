require_relative 'wagon'

# Passenger wagon entity
class PassengerWagon < Wagon
  attr_reader :type
  
  def initialize
    @type = PassengerTrain
  end
end
