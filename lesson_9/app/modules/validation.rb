module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :validations
    
    def validate(name, prop = {})
      @validations ||= Hash.new( {} )
      validations[name] = prop
    end
    
    def inherited(sub)
      sub.validations = @validations
    end
  end
  
  module InstanceMethods
    def validate!
      self.class.validations.each do |name, properties|
        properties.each do |type, prop|
          if type == :presence
            message = "Value of attribute: #{name} is nil or empty"
            raise ArgumentError, message unless value_presence? name
          elsif type == :format
            message = "Value of attribute name: #{name}, doesn't match with format: #{prop}"
            raise ArgumentError, message unless valid_format?(name, prop)
          elsif type == :type
            message = "Value of attribute name: #{name}, doesn't match the specified class: #{prop}"
            raise ArgumentError, message unless valid_class?(name, prop)
          else
            raise ArgumentError, "Unknown attribute type name: #{name}"
          end
        end
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
  
  def value_presence?(attr)
    value = value(attr)
    !(value.nil? || value == '')
  end
  
  def valid_format?(attr, regexp)
    value(attr) =~ regexp
  end
  
  def valid_class?(attr, class_name)
    self_class = value(attr).class
    self_class == class_name
  end
end
