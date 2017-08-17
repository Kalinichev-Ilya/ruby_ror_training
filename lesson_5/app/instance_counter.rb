module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :instances
  end
  
  module InstanceMethods
    def register_instance
      if self.class.instances
        self.class.instances += 1
      else
        self.class.instances = 0
      end
    end
  end
end
