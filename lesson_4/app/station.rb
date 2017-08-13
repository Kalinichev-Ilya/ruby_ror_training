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
    @trains.select { |train| train.type == type }
  end
  
  def move(train)
    @trains.delete train
  end
end
