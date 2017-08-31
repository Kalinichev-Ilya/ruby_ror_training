# Custom validation exception
class ValidationError < StandardError
  attr_reader :obj

  def initialize(obj, message)
    @obj = obj
    super(message)
  end
end
