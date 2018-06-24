class Address {
  
  var street = "Deribasovskaya"
  var number = "1"
  var city = "Odessa"
  var country = "Ukraine"
}

struct Garage {
  var size = 2
}

class House {
  
  var rooms = 1
  var address = Address()
  var garage : Garage? = Garage()
}

class Car {
  var model = "Zaporojec"
  
  func start() {
  }
}


class Person {
  
  var cars : [Car]? = [Car()]
  var house : House? = House()
}

let p = Person()
//p.cars![0]
//p.house

//p.house!.garage!.size

if let house = p.house {
  if let garage = house.garage {
    garage.size
  }
}

p.house?.garage?.size = 3

if let size = p.house?.garage?.size {
  size
}

if (p.house?.garage?.size = 4) != nil {
  print("upgrade!")
} else {
  print("failure")
}

p.house?.garage?.size

p.cars?[0].model

if p.cars?[0].start() != nil {
  print("start!")
} else {
  print("failure!")
}


// ------------------------------

class Symbol {}

class A: Symbol {
  func aa() {}
}

class B: Symbol {
  func bb() {}
}

// -------------------------------------------

//AnyObject
//Any

//import Foundation

let array: [Any] = [A(), B(), Symbol(), A(), B(), A(),
                    Symbol(), A(), "asd", { () -> () in return }]

var count = (A: 0, B: 0, S: 0)

for value in array {
  if value is A {
    count.A += 1
  } else if value is B {
    count.B += 1
  } else if value is Symbol {
    count.S += 1
  }
  
  // optional 'as?'
  if let a = value as? A {
    a.aa()
  }
  
  // forced 'as!' with 'is'
  if value is B {
    let b = value as! B
    b.bb()
  }
  
  if value is String {
    print("String!")
  }
  
  if value is () -> () {
    print("() -> ()")
  }
  
  if let ifunc = value as? () -> () {
    ifunc()
  }
}

count.A
count.B
count.S














