require_relative 'instanc_counter.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  STATION_FORMAT = /[a-zа-я]/i

  attr_reader :start_station, :end_station, :route_name, :stations

  def initialize(route_name, start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [@start_station, @end_station]
    @route_name = route_name
    register_instance
    validate!
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
    raise "Название начальной станции должно содержать только буквы" if start_station !~ STATION_FORMAT
    raise "Название конечной станции должно содержать только буквы" if end_station !~ STATION_FORMAT
  end
end
