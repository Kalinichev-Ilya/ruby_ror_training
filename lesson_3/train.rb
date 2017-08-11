# Train entity
class Train
  attr_reader :speed, :wagons_count, :type, :route

  def initialize(number, type, wagons_count, route)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @route = route
    @station_index = 0
  end

  def accelerate(speed)
    if @speed + speed < 0
      @speed = 0
    else
      @speed += speed
    end
  end

  def route=(route)
    @station_index = 0
    @route = route
  end

  def brake
    @speed = 0
  end

  def add_wagon
    @speed.zero? ? @wagons_count + 1 : false
  end

  def current_station
    @route.stations[@station_index]
  end

  def go_to_the_next_station
    last_station? ? @station_index += 1 : false
  end

  def go_to_the_previous_station
    first_station? ? false : @station_index -= 1
  end

  def next_station
    last_station? ? @route.stations[@station_index + 1] : false
  end

  def previous_station
    first_station? ? false : @route.stations[@station_index - 1]
  end

  private

  def last_station?
    @station_index < @route.stations.count - 1
  end

  def first_station?
    @station_index.zero?
  end
end
