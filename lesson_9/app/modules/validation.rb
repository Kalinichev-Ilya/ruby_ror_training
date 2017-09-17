module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, prop = {})
      @validations ||= {}
      validations[name] = prop
    end

    def inherited(sub)
      sub.validations = @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |name, properties|
        properties.each { |type, prop| send type, name, prop }
      end
    end

    def valid?
      validate! ? true : false
    end
  end

  protected

  def value(var)
    instance_variable_get("@#{var}")
  end

  def presence(*attr)
    value = value(attr.first)
    message = "Value of attribute: #{attr.first} is nil or empty"
    raise ArgumentError, message if value.nil? || value == ''
  end

  def format(attr, regexp)
    message = "Value of attribute name: #{attr}, doesn't match with format: #{regexp}"
    raise ArgumentError, message unless value(attr) =~ regexp
  end

  def type(attr, class_name)
    self_class = value(attr).class
    message = "Value of attribute name: #{attr}, doesn't match the specified class: #{class_name}"
    raise ArgumentError, message unless self_class == class_name
  end
end
