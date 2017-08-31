require_relative 'exceptions/validation_error'

# Station entity
class Station
  attr_reader :name, :trains

  class << self
    attr_accessor :stations
  end
  @stations = []

  def initialize(name, trains = [])
    @name = name
    validate!
    @trains = trains
    self.class.stations << self
  end

  def each_train
    return to_enum(:each_train) unless block_given?
    @trains.each { |train| yield(train) }
  end

  def valid?
    validate! ? true : false
  end

  def self.all
    @stations
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.class == type }
  end

  def move(train)
    @trains.delete train
  end

  def to_s
    name.capitalize.to_s
  end

  protected

  FORMAT = /^[a-z]+-?\s?[a-z]+$/i

  def does_not_match
    name !~ FORMAT
  end

  def validate!
    raise ValidationError.new(name, 'Name has invalid format') if does_not_match
    true
  end
end
