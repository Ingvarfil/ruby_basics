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
  r1 = Route.new("Lublino-Klin", Station.new("Lublino"), Station.new("Klin"))

  @ar_trains << PassengerTrain.new(11)
  @ar_trains << PassengerTrain.new(23)
  @ar_trains << PassengerTrain.new(48)

  @ar_trains << CargoTrain.new(102)
  @ar_trains << CargoTrain.new(354)
  @ar_trains << CargoTrain.new(342)
  @ar_trains << CargoTrain.new(952)

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
