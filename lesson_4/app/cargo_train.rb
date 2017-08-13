require_relative 'train'

# Cargo train entity
class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = 'cargo'
  end
end
