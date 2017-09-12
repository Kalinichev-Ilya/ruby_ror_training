require_relative 'modules/validation'
require_relative 'modules/accessors'
require_relative 'station'

# Route entity
class Route
  include Validation
  extend Accessors
  
  attr_reader :stations, :first, :last

  validate :first, type: Station
  validate :last, type: Station

  def initialize(first, last)
    @first = first
    @last = last
    validate!
    @stations = [first, last]
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
  
  def first_station?(station)
    @stations.index(station).zero?
  end

  def last_station?(station)
    station == @stations.last
  end
end
