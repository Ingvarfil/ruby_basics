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
  attr_reader :number, :speed, :wagons, :type, :current_station, :previous_station, :next_station, :rout

  def initialize(number, type, wagons = 0)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @rout = nil
  end

  def pick_up_speed(value)
    @speed += value
  end
    
  def stop
    @speed = 0
  end

# Прицепить вагоны, если поезд стоит. Тип поезда и тип вагона должны совпадать
  def hitch_wagon(wagon)
    if @speed.zero?
      if self.type == wagon.type
        wagons.push(wagon)
      else
        puts "Поезд и вагоны, должны быть одного типа."
      end      
    else
      puts "Остановите поезд, прежде чем прицеплять вагоны!"
    end

  end

# Отцепить вагоны, если поезд стоит.
  def unhitch_wagon(wagon)
    if @speed.zero?
      @wagons.delete(wagon)
      puts "Вагон #{wagon.type} отцеплен!"  
    else
      puts "Остановите поезд, прежде чем отцеплять вагоны!"      
    end
  end

  def rout(route)
    @rout = route
    @current_station = @rout.stations.first
    @current_station.add_train(self)
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

  def forward
    if @current_station == rout.last
      puts "Поезд находится на конечной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def backward
    if @current_station == rout.first
      puts "Поезд находится на начальной станции маршрута"
    else
      @current_station.send_train(self)
      @current_station = previous_station
      @current_station.add_train(self)
    end
  end

end
