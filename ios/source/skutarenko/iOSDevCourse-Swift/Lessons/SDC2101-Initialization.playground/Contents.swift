import Foundation

class Human {
  var weight: Int
  var age: Int
  
  // designated initializer
  init(weight: Int, age: Int) {
    self.weight = weight
    self.age = age
  }
  
  // convenience initializer
  convenience init(age: Int) {
    self.init(weight: 0, age: age)
  }
  
  convenience init(weight: Int) {
    self.init(weight: weight, age: 0)
  }
  
  convenience init() {
    self.init(weight: 0)
  }
  
  func test(){}
  
  deinit {
    print("Human deinitialized")
  }
}


enum Color: Int {
  case Black
  case White
  
  init?(_ value: Int) {
    switch value {
    case 0: self = Black
    case 1: self = White
    default: return nil
    }
  }
}

let color1 = Color(1)
let color2 = Color(rawValue: 0)
print(color1?.rawValue)
print(color2?.rawValue)






struct Size {
  var width: Int
  var height: Int
  
  init?(width: Int, heigth: Int) {
    if width < 0 && heigth < 0 { return nil }
    self.width = width
    self.height = heigth
  }
}








class Friend: Human {
  var name: String
  let skin: Color = { return Color(Int(arc4random_uniform(2)))! }()
  
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
    super.init(weight: 0, age: 0)
  }
  
  // must override in subclass
  required init() {
    self.name = "Hi"
    super.init(weight: 0, age: 0)
  }
  
  deinit {
    print("Friend deinitialized")
  }
}

let f = Friend(name: "abc")
if let n = f?.name { print(n) }

class BestFriend: Friend {
  override init(name: String) {
    if name.isEmpty { super.init() }
    else { super.init(name: name)! }
  }
  
  required init() {
    super.init()
  }
  
  deinit {
    print("BestFriend deinitialized")
  }
}

f?.skin

// deinit test
var friends = [BestFriend]()
for _ in 0..<100 {
  //let a = BestFriend()
  //friends.append(a)
}

print(BestFriend())





