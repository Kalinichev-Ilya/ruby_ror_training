require_relative 'wagon'

# Cargo wagon entity
class CargoWagon < Wagon
  def initialize
    @type = 'cargo'
  end
end
