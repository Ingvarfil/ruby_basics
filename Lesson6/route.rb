require_relative 'instanc_counter.rb'

class Route
  include InstanceCounter

  attr_reader :start_station, :end_station, :route_name, :stations

  def initialize(route_name, start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [@start_station, @end_station]
    @route_name = route_name
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
