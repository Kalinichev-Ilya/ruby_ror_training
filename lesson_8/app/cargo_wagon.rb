require_relative 'wagon'
require_relative 'cargo_train'

# Cargo wagon entity
class CargoWagon < Wagon
  def initialize(capacity = 0.0)
    super
    @type = CargoTrain
  end

  def take_a_place(volume)
    @occuped_place = [@occuped_place + volume, @capacity].min
  end
end
