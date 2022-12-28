class WagonCargo < Wagon
  attr_reader :occupied_volume, :accessible_volume, :volume

  def initialize(number, type = 'товарный')
    @volume = 80
    @occupied_volume = 0
    @accessible_volume = @volume
    super
  end

  def take_volume(volume)
    validate!
    @accessible_volume -= volume
    @occupied_volume += volume
  end

  protected

  def validate!
    raise "Свободного объема больше нет"  if @volume <= @occupied_volume
  end
end
