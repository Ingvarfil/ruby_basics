module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    @@values = []
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @@values << value
        end
        define_method("#{name}_history")
      end
    end

    def strong_attr_accessor(attr_name, class_name)
      name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(name) }
      define_method("#{attr_name}=") do |value|
        raise TypeError.new("Type error!") unless value.is_a?(class_name.class)
        instance_variable_set("@#{name}", value)
        rescue TypeError => e
        puts "#Error: #{e}"
      end
    end    
  end
end
