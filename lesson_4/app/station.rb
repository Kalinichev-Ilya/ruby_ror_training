# Station entity
class Station
  attr_reader :name, :trains
  
  def initialize(name, trains = [])
    @name = name
    @trains = trains
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
