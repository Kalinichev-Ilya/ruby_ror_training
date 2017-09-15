require_relative 'modules/manufacture'
require_relative 'modules/validation'
require_relative 'modules/accessors'
require_relative 'exceptions/validation_error'

# Train entity
class Train
  include Manufacture
  include Validation
  extend Accessors
  
  attr_reader :number, :wagons, :route, :station_index
  attr_accessor_with_history :speed
  
  validate :number, format: /^(\d{3}|[a-z]{3})-*(\d{2}|[a-z]{2})$/i

  class << self
    attr_accessor :trains
  end
  @trains = {}

  def initialize(number)
    @number = number
    validate!
    @route = nil
    @wagons = []
    @speed = 0
    @station_index = 0
    self.class.trains[number] = self
  end

  def self.find(number)
    @trains[number]
  end

  def each_wagon
    return to_enum(:each_wagon) unless block_given?
    wagons.each { |wagon| yield(wagon) }
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

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && same_type?(wagon)
  end

  def remove_wagon
    @wagons.pop if @speed.zero? && @wagons.count > 0
  end

  def go_to_the_next_station
    @station_index += 1 unless last_station?
  end

  def go_to_the_previous_station
    @station_index -= 1 unless first_station?
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1] unless last_station?
  end

  def previous_station
    @route.stations[@station_index - 1] unless first_station?
  end

  def to_s
    number.upcase.to_s
  end

  # used only in class
  protected

  def last_station?
    @station_index == @route.stations.count - 1
  end

  def first_station?
    @station_index - 1 < 0
  end

  def same_type?(wagon)
    self.class == wagon.type
  end
end
