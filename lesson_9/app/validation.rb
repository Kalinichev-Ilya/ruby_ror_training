module Validation
  
  def validate(name, type, prop = {})
    case type
      when :presence
        message = "Attribute name: #{name} is nil or empty"
        raise ArgumentError, message unless value_presence? name
      when :format
        message = "Attribute name: #{name}, doesn't match with format: #{prop}"
        raise ArgumentError, message unless valid_format?(name, prop)
      when :type
        message = "Attribute name: #{name}, doesn't match the specified class: #{prop}"
        raise ArgumentError, message unless valid_class?(name, prop)
      else
        raise ArgumentError, "Unknown attribute type name: #{type}"
    end
  end
  
  def validate!(name, type, prop = {})
    validate name, type, prop
  end
  
  def valid?
    validate! ? true : false
  end
  
  protected
  
  def value_presence?(name)
    empty = name.delete(' ') == ''
    !(name.nil? || empty)
  end
  
  def valid_format?(name, regexp)
    name =~ regexp
  end
  
  def valid_class?(name, class_name)
    name.is_a? class_name
  end
end
