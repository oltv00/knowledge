// SWIFT Марафон. Урок 9: Switch
/*
 1. Создать строку произвольного текста, минимум 200 символов. Используя цикл и оператор свитч посчитать количество гласных, согласных, цифр и символов.
 */

let str = "Swift was introduced at Apple's 2014 Worldwide Developers Conference (WWDC).[13] It underwent an upgrade to version 1.2 during 2014 and a more major upgrade to Swift 2 at WWDC 2015. Initially a proprietary language, version 2.2 was made open-source software and made available under Apache License 2.0 on December 3, 2015, for Apple's platforms and Linux.[14][15] IBM announced its Swift Sandbox website, which allows developers to write Swift code in one pane and display output in another."

// abcdefghijklmnopqrstuvwxyz
var vowels = "aeiouy"
vowels += vowels.uppercaseString

var consonants = "bcdfghjklmnpqrstvwxz"
consonants += consonants.uppercaseString

let figures = "0123456789"
let symbols = ".,'!@#$%^&*()-=_+[]{}\"\\"
let spaces = " "

let dataSearch = ["vowels"     : vowels,
                  "consonants" : consonants,
                  "figures"    : figures,
                  "symbols"    : symbols,
                  "spaces"     : spaces]

var vowelsSum = 0
var consonantsSum = 0
var figuresSum = 0
var symbolsSum = 0
var spacesSum = 0
var sumOfAllParams = 0

func calculateString(string:String) {
  for takenChar in string.characters {
    for (key, val) in dataSearch {
      for c in val.characters {
        switch takenChar {
        case c where key == "vowels": vowelsSum += 1;
        case c where key == "consonants": consonantsSum += 1;
        case c where key == "figures": figuresSum += 1
        case c where key == "symbols": symbolsSum += 1
        case c where key == "spaces": spacesSum += 1
        default: break
        }
      }
    }
  }
  sumOfAllParams = vowelsSum + consonantsSum + figuresSum + symbolsSum + spacesSum
}

func calculateString_2(string:String) {
  for char in string.characters {
    switch char {
    case "0"..."9": figuresSum += 1
    case " ":       spacesSum += 1
    case "a"..."z": consonantsSum += 1
    case "A"..."Z": consonantsSum += 1
    // ...
    default: break
    }
  }
}

func printParametersWithString(str:String) {
  print("vowels     = \(vowelsSum)")
  print("consonants = \(consonantsSum)")
  print("figures    = \(figuresSum)")
  print("symbols    = \(symbolsSum)")
  print("spaces     = \(spacesSum)")
  print("----------")
  print("str.lenght = \(str.characters.count)")
  print("sum of all parameters = \(sumOfAllParams)")
}

func startTask_1() {
  calculateString(str)
  printParametersWithString(str)
}

//calculateString_2(str)
//startTask_1()

/*
 2. Создайте свитч который принимает возраст человека и выводит описание жизненного этапа
 */

func startTask_2() {
  let ages = [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70]
  for age in ages {
    switch age {
    case 0..<10: print("Age = \(age)")
    case 10..<20: print("Age = \(age)")
    case 20..<30: print("Age = \(age)")
    case 30..<40: print("Age = \(age)")
    case 40..<50: print("Age = \(age)")
    case 50..<60: print("Age = \(age)")
    case 60...70: print("Age = \(age)")
    default: break
    }
  }
}

//startTask_2()

/*
 3. У вас есть имя отчество и фамилия студента (русские буквы). Имя начинается с А или О, то обращайтесь к студенту по имени, если же нет, то если у него отчество начинается на В или Д, то обращайтесь к нему по имени и отчеству, если же опять нет, то в случае если фамилия начинается с Е или З, то обращайтесь к нему только по фамилии. В противном случае обращайтесь к нему по полному имени.
 */

import UIKit

let firstNames = ["Олег", "Алексей", "Владимир", "Евгений"]
let secondNames = ["Викторович", "Денисович", "Сергеевич", "Артемьевич"]
let lastNames = ["Енисенко", "Закиров", "Эйсман", "Будков"]
var students = [String]()

func createStudents() {
  for _ in 0..<10 {
    let fIndex = arc4random_uniform(UInt32(firstNames.count))
    let sIndex = arc4random_uniform(UInt32(secondNames.count))
    let lIndex = arc4random_uniform(UInt32(lastNames.count))
    
    let fName = firstNames[Int(fIndex)]
    let sName = secondNames[Int(sIndex)]
    let lName = lastNames[Int(lIndex)]
    
    let student = "\(lName) \(fName) \(sName)"
    students.append(student)
  }
}

func greetingStudents() {
  let fNameIndex = 1; let sNameIndex = 2; let lNameIndex = 0
  
  for student in students {
    let student = student.componentsSeparatedByString(" ")
    let fName = student[fNameIndex]
    let sName = student[sNameIndex]
    let lName = student[lNameIndex]
    let stdTuple = (lName, fName, sName)
    
    switch stdTuple {
    case (lName, fName, sName) where fName.hasPrefix("О") || fName.hasPrefix("А"):
      print("Hello \(fName) aka \(lName) \(fName) \(sName)")
      
    case (lName, fName, sName) where sName.hasPrefix("В") || sName.hasPrefix("Д"):
      print("Hello \(sName) aka \(lName) \(fName) \(sName)")
      
    case (lName, fName, sName) where lName.hasPrefix("Е") || sName.hasPrefix("З"):
      print("Hello \(lName) aka \(lName) \(fName) \(sName)")
      
    default:
      print("Hello \(lName) \(fName) \(sName)")
    }
  }
  
}

func startTask_3() {
  
  createStudents()
  greetingStudents()
  
}

//startTask_3()

/*
 4. Представьте что вы играете в морской бои и у вас осталось некоторое количество кораблей на поле 10Х10 (можно буквы и цифры, а можно только цифры). Вы должны создать свитч, который примет тюпл с координатой и выдаст один из вариантов: мимо, ранил, убил.
 */

func generateRestrictions() -> Dictionary<String, Dictionary<String, Int>> {
  
  let woundedX = Int(arc4random_uniform(10))
  let woundedY = Int(arc4random_uniform(10))
  
  let killedX = Int(arc4random_uniform(10))
  let killedY = Int(arc4random_uniform(10))
  
  
  let wounded = ["x":woundedX, "y":woundedY]
  let killed = ["x":killedX, "y":killedY]
  return ["wounded":wounded, "killed":killed]
}

func game(life:Int) {
  var life = life
  while (life > 0) {
    let x = Int(arc4random_uniform(10))
    let y = Int(arc4random_uniform(10))
    let shot = (x,y)
    
    let restrictions = generateRestrictions()
    let wounded = restrictions["wounded"]
    let killed = restrictions["killed"]
    
    switch shot {
      
    case let (x,y) where x > wounded!["x"] && y < wounded!["y"] && life > 1:
      life -= 1
      print("wounded with x = \(x), y = \(y) current lifes is = \(life)")
      
    case let (x,y) where x > killed!["x"] && y < killed!["y"] && life == 1:
      life = 0
      print("killed with x = \(x), y = \(y) current lifes is = \(life)")
      
    default:
      print("missy with x = \(x), y = \(y), current lifes is = \(life)")
    }
  }
}

func startTask_4() {
  game(5)
}

//startTask_4()
