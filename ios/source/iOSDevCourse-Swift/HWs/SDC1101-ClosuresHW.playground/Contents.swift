//-----TESTS-----//
func functionA(closure:() -> ()) {}
func functionB(closure:(index:Int) -> ()) {}
func functionC(closure:(array:[Int]) -> Bool) {}
func functionD(array:[Int], closure:(array:[Int]) -> Bool) -> [Int] {return array}

functionA {}
functionB { (index) in }
functionC { (array) -> Bool in true}
functionD([1,2,3]) { (array) -> Bool in false}
//---------------//

// SWIFT Марафон. Урок 11: Клоужеры

/*
 1. Написать функцию, которая ничего не возвращает и принимает только один клоужер, который ничего не принимает и ничего не возвращает . Функция должна просто посчитать от 1 до 10 в цикле и после этого вызвать клоужер. Добавьте println в каждый виток цикла и в клоужер и проследите за очередностью выполнения команд.
 */

func iFunc(closure:() -> ()) {
  for index in 0..<2 {
    print("iFunc index = \(index)")
  }
  closure()
}

func task_1() {
  // auto write
  iFunc {
    // code here ...
    for index in 0..<2 {
      print("auto write closure index = \(index)")
    }
  }
  
  // manual write
  iFunc() {() -> () in
    // code here ...
    for index in 0..<2 {
      print("manual write closure index = \(index)")
    }
  }
}

//task_1()

/*
 2. Используя метод массивов sorted, отсортируйте массив интов по возрастанию и убыванию. Пример показан в методичке.
 */

func task_2() {
  let array = [3,2,1,5,5,11,55,66,123,1]
  print(array.sort { $0 < $1 })
  print(array.sort { $0 > $1 })
}

//task_2()

/*3. Напишите функцию, которая принимает массив интов и клоужер и возвращает инт. Клоужер должен принимать 2 инта (один опшинал) и возвращать да или нет. В самой функции создайте опшинал переменную. Вы должны пройтись в цикле по массиву интов и сравнивать элементы с переменной используя клоужер. Если клоужер возвращает да, то вы записываете значение массива в переменную. в конце функции возвращайте переменную, используя этот метод и этот клоужер найдите максимальный и минимальный элементы массива.
 */

import Foundation

func task_3() {
  
  func randomArray(count count: Int, rangeFrom: UInt32, rangeTo: UInt32) -> [Int] {
    var array = [Int]()
    for _ in 0..<count {array.append(Int(rangeFrom + arc4random_uniform(rangeTo)))}
    return array
  }
  
  func function(array: [Int], completion: (Int?, Int) -> Bool) -> Int? {
    var result : Int?
    for value in array {
      //if result == nil {result = value}
      if completion(result, value) {
        result = value
      }
    }
    return result
  }
  
  let array = randomArray(count:50, rangeFrom: 0, rangeTo: 1000)
  print("max = \(function(array) { $0 == nil || $0 < $1 }!)")
  print("min = \(function(array) { $0 == nil || $0 > $1 }!)")
}

//task_3()

/*4. Создайте произвольную строку. Преобразуйте ее в массив букв. Используя метод массивов sorted отсортируйте строку так, чтобы вначале шли гласные в алфавитном порядке, потом согласные, потом цифры, а потом символы
 */

func task_4() {
  
  // helpers
  func contains(string:String, filter:String) -> Bool {
    return filter.rangeOfString(string) == nil
  }
  
  // filters
  let vowels = "aeiouy" + "aeiouy".uppercaseString
  let consonants = "bcdfghjklmnpqrstvwxz" + "bcdfghjklmnpqrstvwxz".uppercaseString
  let numbers = "0123456789"
  let symbols = ".,'!?@#$%^&*()-=_+[]{}\"\\"
  
  var filters = [
    "vowels"    :[Character](),
    "consonants":[Character](),
    "numbers"   :[Character](),
    "symbols"   :[Character](),
    "unsorted"  :[Character]()
  ]
  
  let input = "#$56ASGASG%34de^0&*c321fASDFGHJKAg298hz65478iikASFASFAS()_?a179!@blac!"
  for char in input.characters {
    let string = String(char)
    
    switch Bool() {
    case contains(string, filter: vowels):
      filters["vowels"]?.append(char)
    case contains(string, filter: consonants):
      filters["consonants"]?.append(char)
    case contains(string, filter: numbers):
      filters["numbers"]?.append(char)
    case contains(string, filter: symbols):
      filters["symbols"]?.append(char)
      
    default:
      filters["unsorted"]?.append(char)
    }
  }
  
  let sequence = ["vowels", "consonants", "numbers", "symbols"]
  var result = ""
  
  // add sequence
  for key in sequence {
    // take filter from sequence
    if let filter = filters[key] {
      // sort the filter chars
      let filter = filter.sort({ $0 < $1 })
      // append to result
      for char in filter {
        result.append(char)
      }
    }
  }
  
  print("input = \(input)")
  print("result = \(result)")
  print("unsorted = \(filters["unsorted"]!)")
}
//task_4()

func task_4v2() {
  
  func priority(string:String) -> Int {
    switch string {
    case "a","e","i","o","u","y": return 0
    case "a"..."z": return 1
    case "0"..."9": return 2
    default: return 3
    }
  }
  
  let input = "!@#$%^&*(12345asdfghjklAHJKL:qwiopAAzzzassš"
  var output = ""
  var array = [String]()
  for c in input.characters {array.append(String(c).lowercaseString)}
  let sorted = array.sort {
    switch (priority($0), priority($1)) {
    case let (x,y) where x < y: return true
    case let (x,y) where x > y: return false
    default: return $0.lowercaseString < $1.lowercaseString
    }
  }
  for c in sorted {output.append(Character(c))}
  print("input = \(input)")
  print("output = \(output)")
}
//task_4v2()

/*5. Проделайте задание №3 но для нахождения минимальной и максимальной буквы из массива букв (соответственно скалярному значению)
 */

func task_5() {
  let input = "wesdfghjkl#$%^&*()"
  func function(string: String, calculate:(Character, Character?) -> Bool) -> Character? {
    var chars = [Character]()
    var result: Character?
    for char in string.characters { chars.append(char) }
    for char in chars {
      if result == nil {result = char}
      if calculate(char, result) {result = char}
    }
    
    var scalars = [UnicodeScalar:UInt32]()
    for scalar in string.unicodeScalars {
      scalars[scalar] = scalar.value
    }
    
    print("----------")
    print("INPUT = \(string)")
    print("SCALARS = \(scalars)")
    return result
  }
  
  print("min = \(function(input) { $0 < $1 }!)")
  print("max = \(function(input) { $0 > $1 }!)")
  
  print("min = \(function("abc") { $0 < $1 }!)")
  print("max = \(function("abc") { $0 > $1 }!)")
}

//task_5()
