# Route entity
class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = []
    @stations << first
    @stations << last
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless first_station?(station) || last_station?(station)
  end

  def first_station?(station)
    @stations.index(station) == 0
  end

  def last_station?(station)
    station == @stations.last
  end
end
