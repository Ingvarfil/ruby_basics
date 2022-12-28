class WagonPass < Wagon
  attr_reader :occupied_seats, :empty_seats

  def initialize(number, type = 'пассажирский')
    @all_seats = 54
    @occupied_seats = 0
    @empty_seats = @all_seats
    super
  end

  def take_seat
    validate!
    @occupied_seats += 1
    @empty_seats -= 1
  end
  
  protected

  def validate!
    raise "Свободных мест больше нет"  if (@all_seats - @occupied_seats).zero?
  end
end
