def data_in
 
  @ar_stations << Station.new("Klin")
  @ar_stations << Station.new("Boloto")
  @ar_stations << Station.new("Depo")
  @ar_stations << Station.new("Piter")
  @ar_stations << Station.new("Bologoe")
  @ar_stations << Station.new("Jopa")
  @ar_stations << Station.new("Lublino")
  @ar_stations << Station.new("Butovo")

  @ar_routes << Route.new("Klin-Boloto", Station.new("Klin"), Station.new("Boloto"))
  @ar_routes << Route.new("Depo-Piter", Station.new("Depo"), Station.new("Piter"))

  @ar_trains << PassengerTrain.new('SM5-85')
  @ar_trains << PassengerTrain.new('W45-74')

  @ar_trains << CargoTrain.new('Z15-D4')
  @ar_trains << CargoTrain.new('X63-03')
  @ar_trains << CargoTrain.new('e02-34')
  @ar_trains << CargoTrain.new('Q52-01')

  @ar_wagons << WagonPass.new(1)
  @ar_wagons << WagonPass.new(2)
  @ar_wagons << WagonPass.new(3)
  @ar_wagons << WagonPass.new(4)

  @ar_wagons << WagonCargo.new(21)
  @ar_wagons << WagonCargo.new(22)
  @ar_wagons << WagonCargo.new(20)
  @ar_wagons << WagonCargo.new(18)
  @ar_wagons << WagonCargo.new(11)
  
end
