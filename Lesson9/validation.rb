module Validation
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end
  end  
end
