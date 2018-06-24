let firstNames = ["Tran", "Lenore", "Bud", "Fredda", "Katrice",
                  "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert"]

let lastNames = ["Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
                 "Homan", "Starns", "Oldham", "Yocum", "Mancia"]

/* Создайте класс человек, который будет содержать имя, фамилию, возраст, рост и вес. Добавьте несколько свойств непосредственно этому классу чтобы контролировать:
 - минимальный и максимальный возраст каждого объекта
 - минимальную и максимальную длину имени и фамилии
 - минимально возможный рост и вес
 - самое интересное, создайте свойство, которое будет содержать количество созданных объектов этого класса*/

import Foundation

class Human {
  static let maxAge = 100
  static let minAge = 0
  
  static let maxFirstNameLength = 10
  static let maxLastNameLength = 10
  
  static let maxHeight: Float = 220
  static let maxWeight: Float = 120
  
  static var totalHumans = 0
  
  var firstName: String {
    didSet {
      if firstName.characters.count > Human.maxFirstNameLength {
        firstName = oldValue
      }
    }
  }
  
  var lastName: String {
    didSet {
      if lastName.characters.count > Human.maxLastNameLength {
        lastName = oldValue
      }
    }
  }
  
  var age: Int {
    didSet {
      if age > Human.maxAge || age < Human.minAge {
        age = oldValue
      }
    }
  }
  
  var height: Float {
    didSet {
      if height > Human.maxHeight {
        height = oldValue
      }
    }
  }
  
  var weight: Float {
    didSet {
      if weight > Human.maxWeight {
        weight = oldValue
      }
    }
  }
  
  init() {
    self.firstName = firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
    self.lastName = lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
    self.age = Int(arc4random_uniform(100))
    self.height = Float(arc4random_uniform(220))
    self.weight = Float(arc4random_uniform(120))
    Human.totalHumans += 1
  }
  
  var description: String {
    return "\(firstName) \(lastName), \(age) ages, \(height) height, \(weight) weight"
  }
}

var humans = [Human]()
let humansCount = 10
for _ in 0..<humansCount {
  humans.append(Human.init())
}

for human in humans {
  print(human.description)
}

print("Total humans = \(Human.totalHumans)")

