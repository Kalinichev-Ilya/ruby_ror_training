# Train entity
class Train
  attr_reader :number, :type, :wagons_count, :route, :speed, :station_index

  def initialize(number, type, wagons_count, route = nil)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @route = route
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

  def add_wagon
    @wagons_count += 1 if @speed.zero?
  end

  def remove_wagon
    @wagons_count -= 1 if @speed.zero? && @wagons_count > 0
  end

  def go_to_the_next_station
    @station_index += 1 unless last_station?
  end

  def go_to_the_previous_station
    @station_index -= 1 unless first_station?
  end

  def next_station
    @route.stations[@station_index + 1] unless last_station?
  end

  def previous_station
    @route.stations[@station_index - 1] unless first_station?
  end

  private

  def last_station?
    @station_index == @route.stations.count - 1
  end

  def first_station?
    @station_index.zero?
  end
end
