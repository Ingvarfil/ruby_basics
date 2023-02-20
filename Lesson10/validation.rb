# frozen_string_literal: true

module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(name, type, *param)
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
