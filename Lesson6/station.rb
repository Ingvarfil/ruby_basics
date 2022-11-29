require_relative 'instanc_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@station_all = []
  
  def self.all
    @@station_all
  end

  def initialize(name)
     @name = name
     @trains = []
     @@station_all << self
     register_instance
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
end
