# frozen_string_literal: true

require_relative 'instanc_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  @@station_all = []
  STATION_FORMAT = /[a-zа-я]/i.freeze

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

  protected

  def validate!
    raise 'Название станции не должно быть пустым' if name.nil?
    raise 'Название станции должно содержать только буквы' if name !~ STATION_FORMAT
  end
end
