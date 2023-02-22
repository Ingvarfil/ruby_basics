module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(name, type_check, *param)
      @validate_atr ||= []
      @validate_atr << [name,type_check, param]    
  end

  module InstanceMethods
    def validate!
      self.class.validate_atr.each do |name, type_check, param|
        value = instance_variable_get("@#{name}")
        case type_check
        when :presence then valid_presence(name, value)
        when :type then valid_type(name, value, param)
        when :format then valid_format(name, value, param)
        end
      end       
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    def valid_presence(name, value)
      return unless value.nil? || value == ''
      raise ArgumentError, "Argument #{name} must be non-zero and not empty string"
    end

    def valid_type(name, value, param)
      return if !value.nil? && value.instance_of?(param)
      raise ArgumentError, "Value #{name}: #{value} is #{value.class} not #{param}"
    end

    def valid_format(name, value, param)
      valid_type = value.instance_of?(String) || value.instance_of?(Symbol)
      return if valid_type && value.match?(param)
      raise ArgumentError, "Value #{name}: #{value} did not pass the test: #{param}"
    end
  end
end
