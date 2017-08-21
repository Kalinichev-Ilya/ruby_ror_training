# Route entity
class Route
  attr_reader :stations
  
  def initialize(first, last)
    @first = first
    @last = last
    validate!
    @stations = [first, last]
  end
  
  def validate!
    if not_a_station(first) || not_a_station(last)
      raise ValidationError.new(first, 'The route receives only stations')
    end
    true
  end
  
  def valid?
    validate! ? true : false
  end
  
  def add_station(station)
    @stations.insert(-2, station) if valid?
  end
  
  def delete_station(station)
    @stations.delete(station) unless first_station?(station) || last_station?(station)
  end
  
  def to_s
    "#{@stations[0].name.capitalize} - #{@stations[-1].name.capitalize}"
  end
  
  protected
  
  attr_reader :first, :last
  
  def not_a_station(station)
    station.class != Station
  end
  
  def first_station?(station)
    @stations.index(station).zero?
  end
  
  def last_station?(station)
    station == @stations.last
  end
end
