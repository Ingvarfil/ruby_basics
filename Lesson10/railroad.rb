# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_pass'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'
require_relative 'create_menu'
require_relative 'info_menu'
require_relative 'change_menu'

class RailRoad
  attr_reader :route_name

  include Create_menu
  include Info_menu
  include Change_menu

  def initialize
    @ar_stations = []
    @ar_trains = []
    @ar_routes = []
    @ar_wagons = []
  end

  def main_menu
    loop do
      main_menu_text
      menu_input = gets.chomp.to_i
      case menu_input
      when 1 then create_menu
      when 2 then info_menu
      when 3 then change_menu
      when 0 then break
      end
    end
  end

  def main_menu_text
    puts 'Виртуальная модель железной дороги.'
    puts 'Введите:'
    puts '1 - чтобы создать станцию, маршрут, поезд или вагон'
    puts '2 - чтобы получить информацию об объектах'
    puts '3 - чтобы внести изменения'
    puts '0 - выход из программы'
  end

  def select_route
    name_route_in = $stdin.gets.chomp
    @ar_routes.find { |route| name_route_in == route.route_name } || puts('Такого маршрута нет')
  end

  def select_train
    number = gets.chomp
    train_x = @ar_trains.find { |train| number == train.number }
    if train_x.nil?
      puts 'Такого поезда нет. Создайте поезд.'
      create_train
    else
      train_x
    end
  end

  def list_wagon
    train_x = select_train
    case train_x.type
    when 'пассажирский'
      train_x.train_wagons_info(train_x.wagons) do |wagon|
        puts "Номер вагона: #{wagon.number}, тип #{wagon.type}."
        puts "Места: свободные #{wagon.empty_seats}, занятые #{wagon.occupied_seats}."
      end
    when 'товарный'
      train_wagons_info(train.wagons) do |wagon|
        puts "Номер вагона: #{wagon.number}, тип #{wagon.type}."
        puts "Объем: свободный #{wagon.accessible_volume}, занятый #{wagon.occupied_volume}."
      end
    else
      puts 'Тип поезда не определен'
    end
  end

  def select_wagon
    number = gets.to_i
    wagon_x = @ar_wagons.find { |wagon| number == wagon.number }
    if wagon_x.nil?
      puts 'Такого вагона нет. Создайте вагон'
      create_wagon
    else
      wagon_x
    end
  end
end
