# frozen_string_literal: true

module Create_menu
  def create_menu
    create_menu_text
    create_input = gets.chomp.to_i
    case create_input
    when 1 then create_station
    when 2 then create_route
    when 3 then create_train
    when 4 then create_wagon
    when 0 then main_menu
    end
  end

  def create_menu_text
    puts 'Создать:'
    puts '1 - станцию;'
    puts '2 - маршрут;'
    puts '3 - поезд;'
    puts '4 - вагон;'
    puts '0 - вернуться в основное меню'
  end

  def create_station
    puts 'Введите название станции:'
    name_station = $stdin.gets.chomp.capitalize
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
    puts 'Создаем первую станцию маршрута'
    start_station = create_station
    puts 'Создаем последнюю станцию маршрута'
    end_station = create_station
    route_name = "#{start_station.name}-#{end_station.name}"
    route = Route.new(route_name, start_station, end_station)
    @ar_routes << route
    puts "Создан маршрут #{route.route_name}"
  end

  def create_train
    puts 'Введите номер поезда: '
    number = $stdin.gets.chomp
    puts 'Введите тип поезда (1 - пассажирский, 2 - товарный):'
    type = $stdin.gets.to_i
    case type
    when 1
      trains_new = PassengerTrain.new(number)
      puts "Пассажирский поезд номер #{number} создан."
      @ar_trains << trains_new
      trains_new
    when 2
      trains_new = CargoTrain.new(number)
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
    type = $stdin.gets.to_i
    case type
    when 1
      wagon_new = WagonPass.new(number)
      puts "Пассажирский вагон номер #{number} создан."
      @ar_wagons << wagon_new
      wagon_new
    when 2
      wagon_new = WagonCargo.new(number)
      puts "Товарный вагон номер #{number} создан."
      @ar_wagons << wagon_new
      wagon_new
    else
      puts 'Введите корректный тип вагона (1 - пассажирский, 2 - товарный).'
      create_wagon
    end
  end
end
