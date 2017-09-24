require_relative 'exceptions/validation_error'
require_relative 'modules/accessors'
require_relative 'modules/validation'

# Station entity
class Station
  extend Accessors
  include Validation
  
  attr_reader :trains
  strong_attr_accessor name: String
  
  validate :name, format: /^[a-z]+-?\s?[a-z]+$/i
  
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
end
