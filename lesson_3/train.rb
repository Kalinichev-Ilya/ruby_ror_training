# Train entity
class Train
  attr_accessor :route
  attr_reader :speed, :wagons_count, :type

  def initialize(number, type, wagons_count, route)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
    @route = route
    @station_index = 0
  end

  def accelerate(speed = 0)
    if @speed + speed > 0
      @speed += speed
    else
      puts "Speed can't be negative. Speed is #{@speed + speed}."
    end
  end

  def brake
    @speed = 0
  end

  def add_wagon
    if @speed.zero?
      @wagons_count + 1
    else
      puts "You need to stop the train. You speed is #{@speed}."
    end
  end

  def current_station
    @route.stations[@station_index]
  end

  def go_to_the_next_station
    if @station_index < @route.stations.count
      @station_index += 1
    else
      puts "We at the #{@station_index} station, have nowhere to go."
    end
  end

  def go_to_the_previous_station
    if @station_index != 0
      @station_index -= 1
    else
      puts "We at the #{@station_index} station, have nowhere to go."
    end
  end

  def next_station
    if @station_index + 1 > 0
      @route.stations[@station_index + 1]
    else
      puts "End of route. #{@station_index} station."
    end
  end

  def previous_station
    if @station_index != 0
      @route.stations[@station_index - 1]
    else
      puts 'No previous station.'
    end
  end
end
