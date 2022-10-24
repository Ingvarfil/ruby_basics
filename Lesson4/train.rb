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
  attr_accessor :speed
  attr_reader :number_wagons, :type_train, :current_station, :previous_station, :next_station


  def initialize(number_train, type_train, number_wagons = 0)
    @number_train = number_train
    @type_train = type_train
    @number_wagons = number_wagons
    @speed = 0

  end

  def pick_up_speed(value)
    self.speed = value
  end
    
  def stop
    self.speed = 0
  end

  def hitch_wagon
    if self.speed.zero?
      @number_wagons +=1
    end
  end

  def unhitch_wagon
    if self.speed.zero? && @number_wagons != 0
      @number_wagons -=1
    end
  end

  def rout_train(rout)
    @rout = rout
    @index = 0
    @current_station = rout.get_rout_list[@index]
    station.take_train(self)
   

  end

  def forward_movement
   if @current_station == rout.get_rout_list.last
     puts "Поезд находится на конечной станции маршрута"      
     else
      @index += 1
      station.send_train(self)
      @current_station[@index]
      station.take_train(self)
    end
  end

  def backward_movement
    if @current_station == rout.get_rout_list.first
      puts "Поезд находится на начальной станции маршрута"
     else 
      @index -= 1
      @current_station.send_train(self)
      @current_station[@index]
      @current_station.take_train(self)
    end
  end

end
