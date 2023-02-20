# frozen_string_literal: true

require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :number, :type

  def initialize(number, type)
    @number = number
    @type = type
  end
end
