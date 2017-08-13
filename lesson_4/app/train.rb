# Train entity
class Train
  attr_reader :number, :type, :wagons, :route, :speed, :station_index

  def initialize(number)
    @number = number
    @type = ''
    @route = nil
    @wagons = []
    @speed = 0
    @station_index = 0
  end

  def accelerate(speed)
    @speed = [0, @speed + speed].max
  end

  def route=(route)
    @station_index = 0
    @route = route
  end

  def brake
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end

  def remove_wagon
    @wagons.pop if @speed.zero? && @wagons.any?
  end

  def go_to_the_next_station
    @station_index += 1 unless last_station?
  end

  def go_to_the_previous_station
    @station_index -= 1 unless first_station?
  end

  def current_station
    @route.stations[@station_index]
  end
  
  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1]
  end

  protected

  # used only in class
  def last_station?
    @station_index == @route.stations.count - 1
  end

  def first_station?
    @station_index.zero?
  end
end
