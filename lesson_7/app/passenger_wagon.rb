require_relative 'wagon'
require_relative 'passenger_train'

# Passenger wagon entity
class PassengerWagon < Wagon
  def initialize(capacity)
    super
    @type = PassengerTrain
  end
  
  def take_a_place
    @occuped_place += 1 if there_are_places?
  end
  
  protected
  
  def there_are_places?
    next_value = @occuped_place + 1
    next_value <= @capacity
  end
end
