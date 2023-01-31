require_relative 'instanc_counter.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation
  @@all_routes = []

  attr_reader :start_station, :end_station, :route_name, :stations

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

  protected

  def validate!
    raise "Название начальной станции не должно быть пустым" if start_station.nil?
    raise "Название конечной станции не должно быть пустым" if end_station.nil?
  end
end
