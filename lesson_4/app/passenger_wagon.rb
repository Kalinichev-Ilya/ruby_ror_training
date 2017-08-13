require_relative 'wagon'

# Passenger wagon entity
class PassengerWagon < Wagon
  def initialize
    @type = 'passenger'
  end
end
