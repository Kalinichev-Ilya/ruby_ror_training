require_relative 'modules/manufacture'

# Wagon entity
class Wagon
  include Manufacture
  extend Accessors
  attr_accessor_with_history :type, :occuped_place, :capacity
  
  def initialize(capacity = 0)
    @capacity = capacity
    @occuped_place = 0
    @type = Wagon
  end

  def free_space
    @capacity - @occuped_place
  end

  def take_a_place
    raise NotImplementedError, 'Method is not defined'
  end
end
