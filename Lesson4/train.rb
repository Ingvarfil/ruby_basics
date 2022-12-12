=begin
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route). 
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_reader :number, :speed, :wagons, :type, :current_station, :previous_station, :next_station

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def pick_up_speed(value)
    @speed += value
  end
    
  def stop
    @speed = 0
  end

  def hitch_wagon
    if @speed.zero?
      wagons +=1
    end
  end

  def unhitch_wagon
    if @speed.zero? && @wagons != 0
      @wagons -=1
    end
  end

  def rout(rout)
    @rout = rout
    @current_station = @rout.stations.first
    @current_station.add_station(self)
  end

  def current_station
    @rout.stations.each {|station| station.trains.include?(self)}
  end

  def previous_station
    @rout.stations[@rout.stations.index(@current_station) - 1]
  end

  def next_station
    @rout.stations[@rout.stations.index(@current_station) + 1]
  end

  def move_forvard
    if @current_station == rout.last
      puts "Поезд находится на конечной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def move_backward
    if @current_station == rout.first
      puts "Поезд находится на начальной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = previous_station
      @current_station.add_train(self)
    end
  end

end
