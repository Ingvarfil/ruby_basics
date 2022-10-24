=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).  
=end

class Station
  attr_reader :train_on_station, :station_name

  def initialize(station_name)
     @station_name = station_name
     @train_on_station = []
  end

  def take_train(train)
    @train_on_station.push(train)
  end

  def send_trainsend_train(train)
    @train_on_station.delete(train)
  end

  def get_list_trains_on_station_type(type)
    puts "Станция #{station_name}. Поезда типа #{type}:"
    @train_on_station.each do |train|
       if train.type_train == type
         puts train.number_train
       end
    end
  end 

end
