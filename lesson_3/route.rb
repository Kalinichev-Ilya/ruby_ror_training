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
    @stations.delete station unless first_station? || last_station?(station)
  end

  def first_station?
    index.zero?
  end

  def last_station?(station)
    @stations.index(station) == @stations.count - 1
  end
end
