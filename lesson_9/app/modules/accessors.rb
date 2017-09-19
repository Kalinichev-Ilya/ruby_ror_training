module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      name = "@#{method}"
      define_method(method) { instance_variable_get(name) }

      container_name = "@#{method}_history"
      define_method("#{method}=") do |var|
        instance_variable_set(container_name, []) unless instance_variable_defined?(container_name)
        instance_variable_get(container_name) << var
        instance_variable_set(name, var)
      end

      define_method("#{method}_history") do
        instance_variable_set(container_name, []) unless instance_variable_defined?(container_name)
        instance_variable_get(container_name)
      end
    end
  end

  def strong_attr_accessor(methods)
    methods.each do |method, class_type|
      name = "@#{method}"
      define_method(method) { instance_variable_get(name) }
      define_method("#{method}=") do |var|
        message = "Invalid type #{var.class} for #{method}, expected: #{class_type} "
        raise TypeError, message unless var.is_a?(class_type)
        instance_variable_set(name, var)
      end
    end
  end
end
