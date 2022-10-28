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
end

def create_route

  puts 'Создаем первую станцию маршрута:'
  @start_station = create_station

  puts 'Введите конечную станцию маршрута:'
  @end_station = create_station
  @route_name = "#{@start_station} - #{@end_station}"

  @route_new = Route.new(@route_name, @start_station, @end_station)
  @routes << @route_new


  puts "Маршрут #{@route_new.route_name} создан"

#Посмотреть что тут есть
  @routes.each {|rout| puts "#{rout.route_name}"}
  puts @stations
 
end

  
end
