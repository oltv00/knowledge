/*
 SWIFT Марафон. Урок 23: Опциональные цепочки и приведение типов
 
 Сегодня будем строить свою небольшую социальную сеть.
 
 1. Сделать класс Человек, у этого класса будут проперти Папа, Мама, Братья, Сестры (всё опционально). Сделать примерно 30 человек, взять одного из них, поставить ему Папу/Маму. Папе и Маме поставить Пап/Мам/Братьев/Сестер. Получится большое дерево иерархии. Посчитать, сколько у этого человека двоюродных Братьев, троюродных Сестёр, Теть, Дядь, итд
 
 2. Все сестры, матери,... должны быть класса Женщина, Папы, братья,... класса Мужчины. У Мужчин сделать метод Двигать_диван, у Женщин Дать_указание (двигать_диван). Всё должно работать как и ранее. Всех этих людей положить в массив Семья, пройти по массиву посчитать количество Мужчин и Женщин, для каждого Мужчины вызвать метод Двигать_диван, для каждой женщины Дать_указание.
 
 3. Расширить класс человек, у него будет проперти Домашние_животные. Животные могут быть разные (попугаи, кошки, собаки...) их может быть несколько, может и не быть вообще. Раздать некоторым людям домашних животных. Пройти по всему массиву людей. Проверить каждого человека на наличие питомца, если такой есть - добавлять всех животных в массив животных. Посчитать сколько каких животных в этом массиве.
 
 4. Вся эта живность должна быть унаследована от класса Животные. У всех животных должен быть метод Издать_звук(крик) и у каждого дочернего класса этот метод переопределён на свой, т.е. каждое животное издаёт свой звук. Когда проходим по массиву животных, каждый представитель вида животных должен издать свой звук.
 
 Обязательно используем в заданиях Optional chaining и Type casting
 */

import Foundation

class Human {
  
  var father: Man?
  var mother: Woman?
  var brothers: [Man]?
  var sisters: [Woman]?
  var family: [AnyObject]?
  var pets: [Pet]?
  
  static func initWithCount(count: Int) -> [Human] {
    var array = [Human]()
    for _ in 0..<count {
      array.append(Human())
    }
    return array
  }
  
  func makePerson() {
    
    let cBrothers = 1 + Int(arc4random_uniform(4))
    let cSisters = 1 + Int(arc4random_uniform(4))
    
    father = Man()
    mother = Woman()
    brothers = Man.initWithCount(cBrothers)
    sisters = Woman.initWithCount(cSisters)
    family = [father!, mother!, brothers!, sisters!]
    
    if let pets = makePets() {
      self.pets = pets
      family?.append(pets)
    }
  }
  
  func makeFamily() {
    if let family = family {
      for person in family {
        
        if person is Human {
          let person = person as! Human
          person.makePerson()
          
        } else {
          
          if person is [Human] {
            let persons = person as! [Human]
            
            for person in persons {
              person.makePerson()
            }
          }
        }
      }
    }
  }
  
  func makePets() -> [Pet]? {
    let isHavePets = arc4random_uniform(1000000)
    if isHavePets % 2 == 0 {
      return nil
    } else {
      var pets = [Pet]()
      let count = 1 + Int(arc4random_uniform(3))
      for _ in 0..<count {
        let petIdx = Int(arc4random_uniform(3))
        let pet = Pet().initWithIdx(petIdx)
        pets.append(pet)
        return pets
      }
    }
    return nil
  }
}

class Man: Human {
  static func initWithCount(count: Int) -> [Man] {
    var array = [Man]()
    for _ in 0..<count {
      array.append(Man())
    }
    return array
  }
  
  func work() {
    print("working...")
  }
}

class Woman: Human {
  static func initWithCount(count: Int) -> [Woman] {
    var array = [Woman]()
    for _ in 0..<count {
      array.append(Woman())
    }
    return array
  }
  
  func instruct() {
    print("instructing...")
  }
}

class Pet {
  enum Type: Int {
    case Bird, Cat, Dog
  }
  
  func initWithIdx(idx: Int) -> Pet {
    switch idx {
    case Type.Bird.rawValue: return Bird()
    case Type.Cat.rawValue: return Cat()
    case Type.Dog.rawValue: return Dog()
    default: return Pet()
    }
  }
  
  func makeSound() {}
}

class Bird: Pet {
  override func makeSound() {
    print("Squawk, cheep, whoot, whoo whoo, coo, caw")
  }
}

class Cat: Pet {
  override func makeSound() {
    print("Rarrr, meow, purr, hiss")
  }
}

class Dog: Pet {
  override func makeSound() {
    print("grrrrrrrr......WRUFF WRUFF")
  }
}

func calculate(array: [AnyObject]) -> [AnyObject] {
  var result = [AnyObject]()
  for person in array {
    if let person = person as? Human {
      result.append(person)
    } else if let persons = person as? [Human] {
      result.appendContentsOf(calculate(persons))
    }
  }
  return result
}

var c = (aunts: 0, uncles: 0, mens: 0, womens: 0)
var cPets = (birds: 0, cats: 0, dogs: 0)
var pets = [Pet]()

let me = Human()
me.makePerson()
me.makeFamily()

c.uncles += me.father?.brothers?.count ?? 0
c.uncles += me.mother?.brothers?.count ?? 0
c.aunts += me.father?.sisters?.count ?? 0
c.aunts += me.mother?.sisters?.count ?? 0

let family = calculate(me.family!)
for person in family {
  if let person = person as? Man {
    person.work()
    c.mens += 1
  } else if let person = person as? Woman {
    person.instruct()
    c.womens += 1
  }
  
  if let person = person as? Human {
    if let personPets = person.pets {
      pets.appendContentsOf(personPets)
    }
  }
}

for pet in pets {
  pet.makeSound()
  if let pet = pet as? Bird {
    cPets.birds += 1
  } else if let pet = pet as? Cat {
    cPets.cats += 1
  } else if let pet = pet as? Dog {
    cPets.dogs += 1
  }
}

print("uncles = \(c.uncles)")
print("aunts = \(c.aunts)")
print("men = \(c.mens)")
print("women = \(c.womens)")
print("pets = \(pets.count)")
print("Birds = \(cPets.birds)")
print("Cats = \(cPets.cats)")
print("Dogs = \(cPets.dogs)")


