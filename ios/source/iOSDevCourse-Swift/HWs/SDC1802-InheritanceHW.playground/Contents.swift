/*
 2. Создать базовый клас "транспортное средство" и добавить три разных проперти: скорость, вместимость и стоимость одной перевозки (computed). Создайте несколько дочерних класов и переопределите их компютед проперти у всех. Создайте класс самолет, корабль, вертолет, машина и у каждого по одному объекту. В компютед пропертис каждого класса напишите свои значения скорости, вместимости, стоимости перевозки. + у вас должен быть свой метод который считает сколько уйдет денег и времени что бы перевести из пункта А в пункт В определенное количество людей с использованимем наших транспортных средств. Вывести в консоль результат (как быстро сможем перевести, стоимость, количество перевозок). Используем полиморфизм
 */

class TransportVehicle {
  var velocity: Int { return 100 }  // km per hour
  var capacity: Int { return 50 }   // peoples
  var cost: Int { return 5 }        // per one km
  
  func move(peoples: Int, atDistance distance: Int) {
    
    print("\nSpecifications")
    print("Velocity = \(velocity)")
    print("Capacity = \(capacity)")
    print("Cost = \(cost)$ per km")
    
    let money = cost * distance
    var trips = peoples / capacity
    if peoples % capacity != 0 { trips += 1 }
    
    let minutes = trips * Int(60 * (Float(distance) / Float(velocity)))
    let hours = minutes / 60
    
    print("For \(peoples) peoples and \(distance) km done \(trips) trips")
    print("Spend \(minutes) minutes (~\(hours) hours), and \(money) dollars")
  }
}

class Airplane: TransportVehicle {
  override var velocity: Int { return super.velocity * 10 }
  override var capacity: Int { return super.capacity * 10 }
  override var cost: Int { return super.cost * 6 }
  
  override func move(peoples: Int, atDistance distance: Int) {
    print("\nAirplane")
    super.move(peoples, atDistance: distance)
  }
}

class Helicopter: TransportVehicle {
  override var velocity: Int { return super.velocity + 50 }
  override var capacity: Int { return super.capacity / 10 }
  override var cost: Int { return super.cost * 5 }
  
  override func move(peoples: Int, atDistance distance: Int) {
    print("\nHelicopter")
    super.move(peoples, atDistance: distance)
  }
}

class CargoShip: TransportVehicle {
  override var velocity: Int { return super.velocity / 2 }
  override var capacity: Int { return super.capacity * 3 }
  override var cost: Int { return super.cost * 2 }
  
  override func move(peoples: Int, atDistance distance: Int) {
    print("\nCargoShip")
    super.move(peoples, atDistance: distance)
  }
}

class Car: TransportVehicle {
  override var velocity: Int { return super.velocity }
  override var capacity: Int { return super.capacity / 10 }
  override var cost: Int { return super.cost / 5 + 1 }
  
  override func move(peoples: Int, atDistance distance: Int) {
    print("\nCar")
    super.move(peoples, atDistance: distance)
  }
}

let airplate = Airplane()
let helicopter = Helicopter()
let cargoShip = CargoShip()
let car = Car()

let transporters = [airplate, helicopter, cargoShip, car]
for transport in transporters {
  transport.move(1000, atDistance: 10000)
}





