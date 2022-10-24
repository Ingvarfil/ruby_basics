=begin
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываются при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end


class Route
  attr_reader :start_station, :end_station, :intermediate_station, :rout_list

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_station = []
    @rout_list = []

  end

  def add_intermediate_station(station)
    @intermediate_station.push(station)
  end

  def delete_intermediate_station(station)
    @intermediate_station.delete(station)
  end

  def get_rout_list
    @rout_list = [@start_station, @intermediate_station, @end_station].flatten
    #rout.each  {|item| puts "#{item}"}
  end

end
