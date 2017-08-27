require_relative 'wagon'
require_relative 'cargo_train'

# Cargo wagon entity
class CargoWagon < Wagon
  def initialize(capacity)
    super
    @type = CargoTrain
  end
  
  def take_a_place(volume)
    @occuped_place += volume if there_are_places?(volume)
  end
  
  private
  
  def there_are_places?(volume)
    next_value = @occuped_place + volume
    next_value <= @capacity
  end
end
