# frozen_string_literal: true

module Change_menu
  def change_menu
    change_menu_text
    change_input = gets.to_i
    case change_input
    when 1 then add_stations
    when 2 then delete_station
    when 3 then train_route
    when 4 then move_forward
    when 5 then move_back
    when 6 then add_wagons
    when 7 then delete_wagons
    when 8 then take_seat_or_volume
    when 0 then main_menu
    end
  end

  def change_menu_text
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
  end

  def add_stations
    puts 'Введите название маршрута:'
    name_route_in = $stdin.gets.chomp
    route_x = @ar_routes.find { |route| name_route_in == route.route_name }
    station_add = create_station
    route_x.add_station(station_add)
    puts "Станция #{station_add.name} добавлена в маршрут #{route_x.route_name}."
  end

  def delete_stations
    puts 'Введите название маршрута:'
    name_route_in = $stdin.gets.chomp
    route_x = @ar_routes.find { |route| name_route_in == route.route_name }
    puts 'Введите название станции:'
    station_in = $stdin.gets.chomp.capitalize
    station_del = route_x.route.find { |station| station_in == station.name }
    route_x.delete_station(station_del)
    puts "Станция #{station_in} удалена из маршрута #{route_x.route_name}."
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

  def add_wagons
    puts 'Введите номер поезда:'
    train_x = select_train
    puts 'Введите номер вагона:'
    wagon_x = select_wagon
    train_x.hitch_wagon(wagon_x)
  end

  def delete_wagons
    puts 'Введите номер поезда:'
    train_x = select_train
    puts 'Введите номер вагона:'
    wagon_x = select_wagon
    train_x.unhitch_wagon(wagon_x)
  end

  def take_seat_or_volume
    puts 'Введите номер вагона:'
    wagon_x = select_wagon
    case wagon_x.type
    when 'пассажирский'
      wagon_x.take_seat
    when 'товарный'
      puts 'Укажите объм:'
      volume = gets.to_f
      take_volume(volume)
    end
  end
end
