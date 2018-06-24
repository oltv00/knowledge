

// CLASS
class Human {
  var name: String
  var age: Int
  
  init() {
    self.name = ""
    self.age = 0
  }
  
  class func iFunc() {}
}




// STRUCT
struct Point {
  var x: Int
  var y: Int
  
  // Use mutating in struct
  mutating func moveByX(x: Int, andY y: Int) {
    self.x += x
    self.y += y
  }
  
  mutating func moveByX2(x: Int, andY y: Int) {
    self = Point.init(x: self.x + x, y: self.y + y)
  }

}

func move(point: Point, byX x: Int, andY y: Int) -> Point {
  var point = point
  point.x += x
  point.y += y
  return point
}

var p = Point.init(x: 1, y: 1)
//move(p, byX: 2, andY: 4)
move(p, byX: 2, andY: 4)

//p.move(<#T##point: Point##Point#>, byX: <#T##Int#>, andY: <#T##Int#>)
//p.move(byX: <#T##Int#>, andY: <#T##Int#>)
p.moveByX(5, andY: 7)





// ENUM
enum Color: String {

  case White = "White"
  case Black = "Black"
  
  static func numberOfElements() -> Int {
    print("numberOfElements()")
    self.printme()
    return 2
  }
  
  mutating func invert() {
    print("invert()")
    self.printme()
    self = self == White ? Black : White
  }
  
  func printme() { print(self.rawValue) }
  static func printme() { print(self.RawValue.self) }
}

var color = Color.White
color.invert()
Color.numberOfElements()





