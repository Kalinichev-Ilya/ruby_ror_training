# Route entity
class Route
  def initialize(departure, arrival, stations = [])
    @departure = departure
    @arrival = arrival
    @stations = stations
  end

  def add(station)
    @stations << station
  end

  def delete(station)
    @stations.delete station
  end

  def stations
    @stations.unshift @departure
    @stations << @arrival
    @stations
  end
end
