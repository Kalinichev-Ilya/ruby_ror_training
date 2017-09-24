require_relative 'train'

# Cargo train entity
class CargoTrain < Train
  @trains = {}
  
  validate :number, type: String
  
  def initialize(number)
    super(number)
  end
end
