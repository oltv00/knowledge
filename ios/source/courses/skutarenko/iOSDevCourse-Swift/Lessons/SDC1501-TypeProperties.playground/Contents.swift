
// Global Variable

let MaxNameLength = 20

// CLASS

class Human {
  var description: String {return "\(name), \(age)"}
  
  var name: String {
    didSet {
      if name.characters.count > MaxNameLength {
        name = oldValue
      }
    }
  }
  
  lazy var storyOfMyLife /* : String! */ = "This is a story of my entire life..."
  
  static let maxAge = 100
  static var totalHumans = 0
  
  // Computed Properties for type
  class var maxAgeClass: Int {
    return 100
  }
  
  var age: Int {
    didSet {
      if age > Human.maxAge {
        age = oldValue
      }
    }
  }
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
    Human.totalHumans += 1
  }
}

for _ in 0..<10 {
  let human = Human.init(name: "Peter", age: 40)
}
Human.totalHumans

let human = Human(name: "abc", age: 10)
human.name = "sdfasdfasdfasdgasdgasdgasdgasdgasdgasgsdgasdgasdgsdgasg"
human.name

print(human)
human.storyOfMyLife







// STRUCT

struct Cat {
  var description: String {
    return "Name = \(name), age = \(age), total cats = \(Cat.totalCats)"
  }
  
  var name: String {
    didSet {
      if name.characters.count > MaxNameLength {
        name = oldValue
      }
    }
  }
  
  static let maxAge = 20
  static var totalCats = 0
  
  var age: Int {
    didSet {
      if age > Cat.maxAge {
        age = oldValue
      }
    }
  }
  
  init (name: String, age: Int) {
    self.name = name
    self.age = age
    Cat.totalCats += 1
  }
}

var cat1 = Cat.init(name: "Whiten", age: 10)
var cat2 = Cat.init(name: "Whiten", age: 10)
var cat3 = Cat.init(name: "Whiten", age: 10)
print(cat1.description)





// ENUM

enum Direction {
  
  static let enumDescription = "Derections in the game"
  
  case Left
  case Right
  case Top
  case Bottom
  
  var isVertical: Bool {
    return self == .Top || self == .Bottom
  }
  
  var isHorizontal: Bool {
    return !isVertical
  }
}

Direction.enumDescription

let direction = Direction.Right
direction.isVertical
direction.isHorizontal




