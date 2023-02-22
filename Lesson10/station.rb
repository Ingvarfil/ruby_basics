# frozen_string_literal: true

require_relative 'instanc_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  include Accessors
  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-zа-я]/i

  @@station_all = []
 
  def self.all
    @@station_all
  end

  def initialize(name)
    @name = name
    @trains = []  
    validate!
    @@station_all << self
    register_instance
  end

  def station_train_info(&block)
    raise 'Блок не передан' unless block_given?

    @trains.each(&block)
  end

  def add_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def get_list_trains(type)
    @trains.select { |train| train.number if train.type == type }
  end
end
