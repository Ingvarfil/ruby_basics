require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_pass.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'
require_relative 'data_in.rb'

@stations = []
@trains = []
@routes = []
@wagons = []

data_in

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

  if @stations.find { |station| name_station == station.name }
    puts "Станция #{station.name} существует"
  else
    @stations << station
    puts "Станция #{station.name} создана"
  end
  station

end

def create_route
  puts "Создаем первую станцию маршрута"
  start_station = create_station
  
  puts "Создаем последнюю станцию маршрута"
  end_station = create_station

  route_name = "#{start_station.name}-#{end_station.name}"
  route = Route.new(route_name, start_station, end_station)
  @routes << route
  puts "Создан маршрут #{route.route_name}"

end

def add_stations
  puts "Введите название маршрута:"
  name_route_in = STDIN.gets.chomp
  route_x = @routes.find { |route| name_route_in == route.route_name}

  station_add = create_station
  route_x.add_station(station_add)
  puts "Станция #{station_add.name} добавлена в маршрут #{route_x.route_name}."
  
end

def delete_stations
  puts "Введите название маршрута:"
  name_route_in = STDIN.gets.chomp
  route_x = @routes.find { |route| name_route_in == route.route_name}

  puts 'Введите название станции:'
  station_in = STDIN.gets.chomp.capitalize
  station_del = route_x.route.find {|station| station_in == station.name}

  route_x.delete_station(station_del)
  puts "Станция #{station_in} удалена из маршрута #{route_x.route_name}."
  
end

def select_route
  name_route_in = STDIN.gets.chomp
  if @routes.find { |route| name_route_in == route.route_name}
    route_x = @routes.find { |route| name_route_in == route.route_name}  
  else
    puts "Такого маршрута нет"
  end

end

def create_train
  puts 'Введите номер поезда: '
  number = gets.to_i

  puts 'Введите тип поезда (1 - пассажирский, 2 - товарный):'
  type = STDIN.gets.to_i

  if type == 1
    @trains << PassengerTrain.new(number)
    puts "Пассажирский поезд номер #{number} создан."
  elsif type == 2
    @trains << CargoTrain.new(number)
    puts "Товарный поезд номер #{number} создан."
  else
    puts 'Введите корректный тип поезда (1 - пассажирский, 2 - товарный):'
  end
end

def create_wagon
  puts 'Введите номер вагона: '
  number = gets.to_i

  puts 'Введите тип вагона (1 - пассажирский, 2 - товарный):'
  type = STDIN.gets.to_i

  if type == 1
    @wagons << WagonPass.new(number)
    puts "Пассажирский вагон номер #{number} создан."
  elsif type == 2
    @wagons << WagonCargo.new(number)
    puts "Товарный вагон номер #{number} создан."
  else
    puts 'Введите корректный тип вагона (1 - пассажирский, 2 - товарный).'
    create
  end
end

def select_train
  number = gets.to_i
  @trains.each.select { |train| number == train.number }
end

def select_wagon
  number = gets.to_i
  @wagons.each.select { |wagon| number == wagon.number }
end

def add_wagons
  puts 'Введите номер поезда:'
  train_x = select_train

  puts 'Введите номер вагона:'
  wagon_x = select_wagon

  train_x[0].hitch_wagon(wagon_x[0])
end

def delete_wagons
  puts 'Введите номер поезда:'
  train_x = select_train

  puts 'Введите номер вагона:'
  wagon_x = select_wagon

  train_x[0].unhitch_wagon(wagon_x[0])
end

def train_route
  puts 'Введите название маршрута:'
  rout_x = select_route
  puts 'Введите номер поезда:'
  train_x = select_train
  train_x[0].rout(rout_x)
 
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
      puts "Пассажирский поезд номер #{train.number}" if train.type == 'пассажирский'
      puts "Товарный поезд номер #{train.number}" if train.type == 'товарный'
    end
  end

end

def move_forward
  puts 'Введите номер поезда:'
  t = select_train
  t.rout.stations.forward
 
end

def move_backward
  puts 'Введите номер поезда:'
  t = select_train
  t.rout.stations.backward

end

  

