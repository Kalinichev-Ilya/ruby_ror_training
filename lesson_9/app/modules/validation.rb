module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, prop = {})
      @validations ||= {} if validations.nil?
      validations[name] = [] if validations[name].nil?
      validations[name] << prop unless validations[name].include? prop
    end

    def inherited(sub)
      sub.validations = @validations
    end
  end

  module InstanceMethods
    def validate!
      checks = self.class.validations
      puts "#{checks}"
      Hash(checks).each do |name, properties|
        value = instance_variable_get("@#{name}")
        properties.each do |validation|
          validation.each { |type, prop| send type, value, prop }
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end

  protected

  def presence(attr, *)
    message = "Value of attribute: #{attr} is nil or empty"
    raise ArgumentError, message if attr || value == ''
  end

  def format(attr, regexp)
    message = "Value of attribute name: #{attr}, doesn't match with format: #{regexp}"
    raise ArgumentError, message unless attr =~ regexp
  end

  def type(attr, class_name)
    message = "Value of attribute name: #{attr}, doesn't match the specified class: #{class_name}"
    raise ArgumentError, message unless attr.is_a?(class_name)
  end
end
