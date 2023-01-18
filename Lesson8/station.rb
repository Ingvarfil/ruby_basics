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
    register_instance
    validate!
    @@station_all << self
  end

  def station_train_info(&block)
    if block_given?
    @trains.each(&block)
    else
      raise "Блок не передан"
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
    # raise "Станция такая есть" if self.class.all.find { |station| self.name == station.name }
    raise "Название станции не должно быть пустым" if name.nil?
    raise "Название станции должно содержать только буквы" if name !~ STATION_FORMAT
  end
end
