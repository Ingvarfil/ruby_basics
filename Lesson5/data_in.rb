def data_in
  @stations << Station.new("Klin")
  @stations << Station.new("Boloto")
  @stations << Station.new("Depo")
  @stations << Station.new("Piter")
  @stations << Station.new("Bologoe")
  @stations << Station.new("Jopa")
  @stations << Station.new("Lublino")
  @stations << Station.new("Butovo")

  @routes << Route.new("Klin-Boloto", Station.new("Klin"), Station.new("Boloto"))
  @routes << Route.new("Depo-Piter", Station.new("Depo"), Station.new("Piter"))
  r1 = Route.new("Lublino-Klin", Station.new("Lublino"), Station.new("Klin"))

  @trains << PassengerTrain.new(11)
  @trains << PassengerTrain.new(23)
  @trains << PassengerTrain.new(48)

  @trains << CargoTrain.new(102)
  @trains << CargoTrain.new(354)
  @trains << CargoTrain.new(342)
  @trains << CargoTrain.new(952)

  @wagons << WagonPass.new(1)
  @wagons << WagonPass.new(2)
  @wagons << WagonPass.new(3)
  @wagons << WagonPass.new(4)

  @wagons << WagonCargo.new(21)
  @wagons << WagonCargo.new(22)
  @wagons << WagonCargo.new(20)
  @wagons << WagonCargo.new(18)
  @wagons << WagonCargo.new(11)
  
end
