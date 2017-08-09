# Train entity
class Train
  attr_accessor :route
  attr_reader :speed, :wagons_count, :station, :type

  def initialize(number, type, wagons_count, route)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @route = route
    @station_index = 0
  end

  def accelerate(speed = 0)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def add_wagon
    @wagons_count + 1 if @speed.zero?
    puts 'You need to stop the train.' unless @speed.zero?
  end

  def route=(route)
    @route = route
    @station = route.stations[0]
  end

  def current_station
    @station = @route.stations[@station_index]
  end

  def go_to_the_next_station
    @station = @route.stations[@station_index + 1]
  end

  def go_to_the_previous_station
    @station = @route.stations[@station_index - 1]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    @route.stations[@station_index - 1]
  end
end
