# Station entity
class Station
  attr_reader :name

  def initialize(name, trains = [])
    @name = name
    @trains = trains
  end

  # add train
  def add_train(train)
    @trains << train
  end

  # return list of trains
  def train_list
    @trains
  end

  # return list of trains by type
  def trains_by_type
    cargo = []
    passenger = []
    @trains.each do |train|
      cargo << train if train.type == 'cargo'
      passenger << train if train.type == 'passenger'
    end
    { cargo: cargo, passenger: passenger }
  end

  def move(train)
    @trains.delete train
  end
end
