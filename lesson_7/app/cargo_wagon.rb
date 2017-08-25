require_relative 'wagon'

# Cargo wagon entity
class CargoWagon < Wagon
  attr_reader :type
  
  def initialize
    @type = CargoTrain
  end
end
