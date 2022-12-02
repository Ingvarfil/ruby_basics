require_relative 'manufacturer.rb'
require_relative 'instanc_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :speed, :wagons, :type, :current_station, :previous_station, :next_station, :train_route

  @@trains_all = []

  def self.find(number_in)
    train_find = @@trains_all.find { |train| train.number == number_in }
  end

  def initialize(number, type, wagons = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @train_route = nil
    @@trains_all << self
    register_instance
  end

  def pick_up_speed(value)
    @speed += value
  end
    
  def stop
    @speed = 0
  end

# Прицепить вагоны, если поезд стоит. Тип поезда и тип вагона должны совпадать
  def hitch_wagon(wagon)
    if @speed.zero?
      if self.type == wagon.type
        wagons.push(wagon)
      else
        puts "Поезд и вагоны, должны быть одного типа."
      end      
    else
      puts "Остановите поезд, прежде чем прицеплять вагоны!"
    end
  end

# Отцепить вагоны, если поезд стоит.
  def unhitch_wagon(wagon)
    if @speed.zero?
      @wagons.delete(wagon)
      puts "Вагон #{wagon.type} отцеплен!"  
    else
      puts "Остановите поезд, прежде чем отцеплять вагоны!"      
    end
  end

  def assign_route(stations)
    @train_route = stations
    @current_station = @train_route.stations.first
    @current_station.add_train(self)
  end

  def current_station
    @train_route.stations.each {|station| station.trains.include?(self)}
  end

  def previous_station
    @train_route.stations[@train_route.stations.index(@current_station) - 1]
  end

  def next_station
    @train_route.stations[@train_route.stations.index(@current_station) + 1]
  end

  def forward
    if @train_route.stations.size == ((@train_route.stations.index(@current_station)) + 1)
      puts "Поезд находится на конечной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def backward
    if @train_route.stations.index(@current_station) == 0
      puts "Поезд находится на начальной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = previous_station
      @current_station.add_train(self)
    end
  end
end
