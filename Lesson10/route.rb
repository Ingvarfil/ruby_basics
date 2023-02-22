# frozen_string_literal: true

require_relative 'instanc_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  @@all_routes = []

  attr_reader :start_station, :end_station, :route_name, :stations

  validate :start_station, :presence
  validate :end_station, :presence

  def self.all
    @@all_routes
  end

  def initialize(route_name, start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [@start_station, @end_station]
    @route_name = route_name
    register_instance
    validate!
    @@all_routes << self
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
