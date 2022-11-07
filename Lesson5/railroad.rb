require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_pass.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'

class RailRoad
  attr_reader :route_name

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end
  
  # ========== Start Пользовательский интерфейс ==================
  def main_menu
    loop do
      puts 'Виртуальная модель железной дороги.'
      puts 'Введите:'
      puts '1 - чтобы создать станцию, маршрут, поезд или вагон'
      puts '2 - чтобы получить информацию об объектах'
      puts '3 - чтобы внести изменения'
      puts '0 - выход из программы'
      menu_input = gets.chomp.to_i
  
      case menu_input
      when 1
        create_menu
      when 2
        info_menu
      when 3
        change_menu
      when 0
        break
      end
    end
  
  end
  
  def create_menu
    puts 'Создать:'
    puts '1 - станцию;'
    puts '2 - маршрут;'
    puts '3 - поезд;'
    puts '4 - вагон;'
    puts '0 - вернуться в основное меню'
    create_input = gets.chomp.to_i

    case create_input
    when 1
      create_station
    when 2
      create_route
    when 3
      create_train
    when 4
      create_wagon
    when 0
      main_menu
    end

  end

  def info_menu
    puts 'Для получения информации введите:'
    puts '1 - маршруты;'
    puts '2 - поезда;'
    puts '3 - вагоны;'
    puts '4 - станции;'
    puts '0 - вернуться в основное меню.'
    info_input = gets.to_i

    case info_input
    when 1
      show_routes
    when 2
      show_trains
    when 3
      show_wagons
    when 4
      show_stations
    when 0
      main_menu
    end
  end

  def change_menu
    puts 'Выберите действия:'
    puts '1 - добавить станцию к маршруту;'
    puts '2 - удалить станцию из маршрута;'
    puts '3 - назначить маршрут поезду;'
    puts '4 - переместить поезд на следующую станцию маршрута;'
    puts '5 - переместить поезд на предыдущую станцию маршрута;'
    puts '6 - прицепить вагон к поезду;'
    puts '7 - отцепить вагон от поезда;'
    puts '8 - увеличиить скорость поезда;'
    puts '9 - остановить поезд;'
    puts '0 - вернуться в основное меню.'

    change_input = gets.to_i

    case change_input
    when 1
      add_station
    when 2
      delete_station
    when 3
      train_route
    when 4
      move_forward
    when 5
      move_back
    when 6
      add_wagons
    when 7
      delete_wagons
    when 8
      increase_speed
    when 9
      stop_train
    when 0
      main_menu
    end
  end
# ========== End Пользовательский интерфейс ==================

def create_station

  puts 'Введите название станции:'
  name_station = STDIN.gets.chomp.capitalize
  station = Station.new(name_station)
  @stations << station
  puts "Станция #{station.name} создана"
  @stations.each do |station| 
    puts ""
end

def create_route

  puts 'Создаем первую станцию маршрута:'
  first = create_station
  puts 'Введите конечную станцию маршрута:'
  last = create_station

  first = @stations.select { |station| first == station.name }
  last = @stations.select { |station| last == station.name }

  @routes << Route.new(first[0], last[0])

  #puts "Маршрут #{@route_new.route_name} создан"
  puts  @routes

 #Посмотреть что тут есть
  @routes.each do |route|
    puts "Маршрут #{route.route_name}: "
    route.stations.map.with_index(1) do |station, index|
      puts "Станция #{index}: #{station}. Поездов на станции: #{station}."
    end
  end  
  
end

def show_routes
  puts 'Не создано ни одного маршрута!' if @routes.empty?
  @routes.each do |route|
    puts "Маршрут #{route.route_name}: "
    route.stations.map.with_index(1) do |station, index|
      puts "Станция #{index}: #{station.name}. Поездов на станции: #{station.trains.size}."
    end
  end
end

def show_stations
  puts 'Не создано ни одной станции!' if @stations.empty?
  @stations.each do |station|
    station.trains.each do |train|
      puts "Станция #{station.name}. Поезда на станции:"
      puts "Пассажирский поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'пассажирский'
      puts "Грузовой поезд номер #{train.number}, вагонов в поезде #{train.wagon_info.size}." if train.type == 'грузовой'
    end
  end
end

def show_trains
  puts 'Не создано ни одного поезда!' if @trains.empty?
  @trains.each &:info
end

def show_wagons
  puts 'Не создано ни одного вагона!' if @wagons.empty?
  @wagons.each do |wagon|
    puts "Вагон номер #{wagon.number} прицеплен к поезду #{wagon.train}."
  end
end
  
end
