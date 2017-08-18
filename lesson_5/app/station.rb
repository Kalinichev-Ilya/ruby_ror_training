# Station entity
class Station
  attr_reader :name, :trains
  
  class << self
    attr_accessor :stations
  end
  @stations = []
  
  def initialize(name, trains = [])
    @name = name
    @trains = trains
    self.class.stations << self
  end
  
  def self.all
    @stations
  end
  
  def add_train(train)
    @trains << train
  end
  
  def trains_by_type(type)
    @trains.select { |train| train.class == type }
  end
  
  def move(train)
    @trains.delete train
  end
  
  def to_s
    "#{name.capitalize}"
  end
end
