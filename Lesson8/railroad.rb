require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_pass.rb'
require_relative 'wagon.rb'
require_relative 'wagon_pass.rb'
require_relative 'wagon_cargo.rb'
#require_relative 'data_in.rb'

class RailRoad
  attr_reader :route_name

  def initialize
    @ar_stations = []
    @ar_trains = []
    @ar_routes = []
    @ar_wagons = []
  end
  # data_in  
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
    puts '1 - маршруты и поезда на станции'
    puts '2 - информация по поездам и вагонам'
    puts '3 - список станций'
    puts '0 - вернуться в основное меню.'
    info_input = gets.to_i
    case info_input
    when 1
      show_routes
    when 2
      info_trains
    when 3
      list_stations
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
    puts '8 - занять место или объем в вагоне;'
    puts '0 - вернуться в основное меню.'
    change_input = gets.to_i
    case change_input
    when 1
      add_stations
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
      take_seat_or_volume
    when 0
      main_menu
    end
  end
# ========== End Пользовательский интерфейс ==================

def create_station
  puts 'Введите название станции:'
  name_station = STDIN.gets.chomp.capitalize 
  station = Station.new(name_station)
  if @ar_stations.find { |station| name_station == station.name }
    puts "Станция #{station.name} существует"
  else
    @ar_stations << station
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
  @ar_routes << route
  puts "Создан маршрут #{route.route_name}"
end

def add_stations
  puts "Введите название маршрута:"
  name_route_in = STDIN.gets.chomp
  route_x = @ar_routes.find { |route| name_route_in == route.route_name}
  station_add = create_station
  route_x.add_station(station_add)
  puts "Станция #{station_add.name} добавлена в маршрут #{route_x.route_name}."  
end

def delete_stations
  puts "Введите название маршрута:"
  name_route_in = STDIN.gets.chomp
  route_x = @ar_routes.find { |route| name_route_in == route.route_name}
  puts 'Введите название станции:'
  station_in = STDIN.gets.chomp.capitalize
  station_del = route_x.route.find {|station| station_in == station.name}
  route_x.delete_station(station_del)
  puts "Станция #{station_in} удалена из маршрута #{route_x.route_name}."  
end

def select_route
  name_route_in = STDIN.gets.chomp
  if @ar_routes.find { |route| name_route_in == route.route_name}
    route_x = @ar_routes.find { |route| name_route_in == route.route_name}  
  else
    puts "Такого маршрута нет"
  end
end

def create_train
  puts 'Введите номер поезда: '
  number = STDIN.gets.chomp
  puts 'Введите тип поезда (1 - пассажирский, 2 - товарный):'
  type = STDIN.gets.to_i
  if type == 1
    trains_new = PassengerTrain.new(number)
    puts "Пассажирский поезд номер #{number} создан."
    @ar_trains << trains_new
    trains_new
  elsif type == 2
    trains_new =  CargoTrain.new(number)
    puts "Товарный поезд номер #{number} создан."
    @ar_trains << trains_new
    trains_new
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
    wagon_new = WagonPass.new(number)
    puts "Пассажирский вагон номер #{number} создан."
    @ar_wagons << wagon_new
    wagon_new
  elsif type == 2
    wagon_new = WagonCargo.new(number)
    puts "Товарный вагон номер #{number} создан."
    @ar_wagons << wagon_new
    wagon_new
  else
    puts 'Введите корректный тип вагона (1 - пассажирский, 2 - товарный).'
    create_wagon
  end
end

def select_train
  number = gets.chomp
  train_x = @ar_trains.find { |train| number == train.number }
  if train_x.nil?
    puts "Такого поезда нет. Создайте поезд."
    create_train
  else
    train_x
  end
end

def list_wagon
  train_x = select_train
  if train_x.type == 'пассажирский'
    train_x.train_wagons_info(train_x.wagons) { |wagon| puts "Номер вагона: #{wagon.number}, тип #{wagon.type}. Места: свободные #{wagon.empty_seats}, занятые #{wagon.occupied_seats}"}
  elsif train_x.type == 'товарный'
   train_wagons_info(train.wagons) { |wagon| puts "Номер вагона: #{wagon.number}, тип #{wagon.type}. Объем: свободный #{wagon.accessible_volume}, занятый #{wagon.occupied_volume}"}
  else
    puts "Тип поезда не определен"
  end
end

def select_wagon
  number = gets.to_i
  wagon_x = @ar_wagons.find { |wagon| number == wagon.number }
  if wagon_x.nil?
    puts "Такого вагона нет. Создайте вагон"
    create_wagon
  else
    wagon_x  
  end
end

def add_wagons
  puts 'Введите номер поезда:'
  train_x = select_train
  puts 'Введите номер вагона:'
  wagon_x = select_wagon
  train_x.hitch_wagon(wagon_x)
end

def take_seat_or_volume
  puts 'Введите номер вагона:'
  wagon_x = select_wagon
  case wagon_x.type
  when 'пассажирский'
    wagon_x.take_seat  
  when 'товарный'
    puts "Укажите объм:"
    volume = gets.to_f
    take_volume(volume)    
  end
end

def delete_wagons
  puts 'Введите номер поезда:'
  train_x = select_train
  puts 'Введите номер вагона:'
  wagon_x = select_wagon
  train_x.unhitch_wagon(wagon_x)
end

def train_route
  puts 'Введите название маршрута:'
  rout_x = select_route
  puts 'Введите номер поезда:'
  train_x = select_train
  train_x.assign_route(rout_x)
end

def move_forward
  puts 'Введите номер поезда:'
  train_x = select_train
  train_x.forward
end

def move_backward
  puts 'Введите номер поезда:'
  train_x = select_train
  train_x.backward
end

def info_trains
  puts 'Введите номер поезда:'
  train_x = select_train
  train_x.train_wagons_info do | wagon |
    info = "Вагон номер: #{wagon.number}, #{wagon.type}"
    case wagon.type
      when 'пассажирский'
        puts "#{info}, места: свободные #{wagon.empty_seats}, занято #{wagon.occupied_seats}"
      when 'товарный'
        puts "#{info}, объем: свободный #{wagon.accessible_volume}, занято #{wagon.occupied_volume}"
    end
  end
end

def list_stations
  @ar_stations.each {|station | puts station.name }
end

def show_routes
  puts 'Не создано ни одного маршрута!' if @ar_routes.empty?
  @ar_routes.each do |route|
    puts "Маршрут #{route.route_name}: "
    route.stations.each_with_index do |station, index|
      puts "Станция #{index}: #{station.name}:"
      station.station_train_info do | train |
        puts "Поезд номер  #{train.number}, тип #{train.type}, количество вагонов #{train.wagons.size} "
      end 
    end
  end
end
end
