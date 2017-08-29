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
  
  def free_space
    @capacity - @occuped_place
  end

  def take_a_place
    raise NotImplementedError
  end
end
