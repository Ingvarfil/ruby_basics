# frozen_string_literal: true

module Info_menu
  def info_menu
    info_menu_text
    info_input = gets.to_i
    case info_input
    when 1 then show_routes
    when 2 then info_trains
    when 3 then list_stations
    when 0 then main_menu
    end
  end

  def info_menu_text
    puts 'Для получения информации введите:'
    puts '1 - маршруты и поезда на станции'
    puts '2 - информация по поездам и вагонам'
    puts '3 - список станций'
    puts '0 - вернуться в основное меню.'
  end

  def show_routes
    puts 'Не создано ни одного маршрута!' if @ar_routes.empty?
    @ar_routes.each do |route|
      puts "Маршрут #{route.route_name}: "
      route.stations.each_with_index do |station, index|
        puts "Станция #{index}: #{station.name}:"
        station.station_train_info do |train|
          puts "Поезд номер  #{train.number}, тип #{train.type}, количество вагонов #{train.wagons.size} "
        end
      end
    end
  end

  def info_trains
    puts 'Введите номер поезда:'
    train_x = select_train
    train_x.train_wagons_info do |wagon|
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
    @ar_stations.each { |station| puts station.name }
  end
end
