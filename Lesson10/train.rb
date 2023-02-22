# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instanc_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :speed, :wagons, :type, :train_route

  validate :number, :presence
  validate :number, :format, /[a-zа-я0-9]{3}(-?)[a-zа-я0-9]{2}/i

  @@all_trains = []

  def self.find(number_in)
    @@all_trains.find { |train| train.number == number_in }
  end

  def initialize(number, type, _wagons = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @train_route = nil
    @@all_trains << self
    register_instance
    validate!
  end

  def train_wagons_info(&block)
    raise 'Блок не передан' unless block_given?

    @wagons.each(&block)
  end

  def pick_up_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def hitch_wagon(wagon)
    @wagons.push(wagon) if @speed.zero?
  end

  def unhitch_wagon(wagon)
    if @speed.zero?
      @wagons.delete(wagon)
      puts "Вагон #{wagon.type} отцеплен!"
    else
      puts 'Остановите поезд, прежде чем отцеплять вагоны!'
    end
  end

  def assign_route(stations)
    @train_route = stations
    @current_station = @train_route.stations.first
    @current_station.add_train(self)
  end

  def current_station
    @train_route.stations.each { |station| station.trains.include?(self) }
  end

  def previous_station
    @train_route.stations[@train_route.stations.index(@current_station) - 1]
  end

  def next_station
    @train_route.stations[@train_route.stations.index(@current_station) + 1]
  end

  def forward
    if @train_route.stations.size == (@train_route.stations.index(@current_station) + 1)
      puts 'Поезд находится на конечной станции маршрута'
    else
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def backward
    if @train_route.stations.index(@current_station).zero?
      puts 'Поезд находится на начальной станции маршрута'
    else
      @current_station.send_train(self)
      @current_station = previous_station
      @current_station.add_train(self)
    end
  end
end
