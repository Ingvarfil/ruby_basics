require_relative 'instanc_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  @@station_all = []
  STATION_FORMAT = /[a-zа-я]/i
  
  def self.all
    @@station_all
  end

  def initialize(name)
     @name = name
     @trains = []
     @@station_all << self
     register_instance
     validate!
  end

  def station_train_info(trains, &block)
    if block_given?
    trains.each { |train| yield(train) }
    else
      trains
    end
  end

  def add_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_list_trains(type)
    @trains.select {|train| train.number if train.type == type}
  end
  
  protected

  def validate!
    raise "Название станции не должно быть пустым" if self.name.nil?
    raise "Название станции должно содержать только буквы" if self.name !~ STATION_FORMAT
  end
end
