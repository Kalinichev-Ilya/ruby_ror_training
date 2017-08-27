require_relative 'manufacture'

# Wagon entity
class Wagon
  include Manufacture
  attr_reader :type, :occuped_place, :capacity
  
  def initialize(capacity = 0)
    @capacity = capacity
    @occuped_place = 0
    @type = Wagon
  end
  
  def take_a_place
    @occuped_place += 1 if there_are_places?
  end
  
  def free_space
    @capacity - @occuped_place
  end
  
  protected
  
  def there_are_places?
    next_value = @occuped_place + 1
    next_value <= @capacity
  end
end
