# Route entity
class Route
  attr_reader :stations

  def initialize(stations = [])
    @stations = stations
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    index = @stations.index(station)

    if index.zero? || index == @stations.count - 1
      puts "You can't delete the first or last station."
    else
      @stations.delete
    end
  end
end
