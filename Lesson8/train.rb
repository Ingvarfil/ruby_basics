require_relative 'manufacturer.rb'
require_relative 'instanc_counter.rb'
require_relative 'validation.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :speed, :wagons, :type, :current_station, :previous_station, :next_station, :train_route

  @@all_trains = []
  TRAIN_NUMBER_FORMAT = /[a-zа-я0-9]{3}(-?)[a-zа-я0-9]{2}/i

  def self.find(number_in)
    train_find = @@all_trains.find { |train| train.number == number_in }
  end

  def initialize(number, type, wagons = 0)
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
    if block_given?
     @wagons.each { |wagon| yield(wagon) }
    else
      raise "Блок не передан"
    end
  end

  def pick_up_speed(value)
    @speed += value
  end
    
  def stop
    @speed = 0
  end

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

  protected

  def validate!
    raise "Номер не может быть пустым" if number.nil?
    raise "Неправильный формат. Формат номера поезда ХХХ-ХХ, Х- любая буква или цифра, '-' необязательно." if number !~ TRAIN_NUMBER_FORMAT
  end
end
