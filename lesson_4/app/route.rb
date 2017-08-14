# Route entity
class Route
  attr_reader :stations
  
  def initialize(first, last)
    @stations = [first, last]
  end
  
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def delete_station(station)
    @stations.delete(station) unless first_station?(station) || last_station?(station)
  end
  
  def to_s
    "#{@stations[0].name.capitalize} - #{@stations[-1].name.capitalize}"
  end
  
  protected
  
  def first_station?(station)
    @stations.index(station) == 0
  end
  
  def last_station?(station)
    station == @stations.last
  end
end
