// SWIFT Марафон. Урок 10: Функции

/*
 1. Создайте пару функций с короткими именами, которые возвращают строку с классным символом или символами. Например heart() возвращает сердце и т.п. Вызовите все эти функции внутри принта для вывода строки этих символов путем конкатенации.
 */

func smile() -> String {
  return "😬"
}

func cat() -> String {
  return "😼"
}

func sun() -> String {
  return "🌞"
}

func startTask_1() {
  print(smile() + cat() + sun())
}

//startTask_1()

/*
 2. Опять шахматные клетки. Реализовать функцию, которая принимает букву и символ и возвращает строку “белая” или “черная”. Строку потом распечатайте в консоль
 */

func whatColor(string string: Int, column: String) -> String {
  
  if string > 8 {
    return "Incorrect string value = \(string)"
  }
  
  let columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
  let cIdx = columns.indexOf(column)
  
  if cIdx != nil {
    if string % 2 == cIdx! % 2 {
      return "White, string = \(string), column = \(column)"
    } else {
      return "Black, string = \(string), column = \(column)"
    }
  } else {
    return "Incorrect column value = \(column)"
  }
}

func startTask_2() {
  whatColor(string: 1, column: "a")
  whatColor(string: 1, column: "b")
  whatColor(string: 6, column: "q")
  whatColor(string: 9, column: "q")
}

//startTask_2()

/*
 3. Создайте функцию, которая принимает массив, а возвращает массив в обратном порядке. Можете создать еще одну, которая принимает последовательность и возвращает массив в обратном порядке. Чтобы не дублировать код, сделайте так, чтобы функция с последовательностью вызывала первую.
 */

func array_reverse(array: [Int]) -> [Int] {
  return array.reverse()
}

func array_reverse(sequence: Int...) -> [Int] {
  return array_reverse(sequence)
}

func startTask_3() {
  let array = [1,2,3,4,5]
  array_reverse(array)
  array_reverse(1,3,5,7,9)
}

//startTask_3()

/*
 4. Разберитесь с inout самостоятельно и выполните задание номер 3 так, чтобы функция не возвращала перевернутый массив, но меняла элементы в существующем. Что будет если убрать inout?
 */

func array_reverse(inout array: [Int]) {
  array = array.reverse()
}

func startTask_4() {
  var array = [1,2,3,4,5]
  array_reverse(&array)
}

//startTask_4()

/*
 5. Создайте функцию, которая принимает строку, убирает из нее все знаки препинания, делает все гласные большими буквами, согласные маленькими, а цифры меняет на соответствующие слова (9 -> nine и тд)
 */

func number(toString string: String) -> String {
  let transform = ["0" : "zero",  "1" : "one",
                   "2" : "two",   "3" : "three",
                   "4" : "four",  "5" : "five",
                   "6" : "six",   "7" : "seven",
                   "8" : "eight", "9" : "nine"]
  return transform[string]!
}

import Foundation
func transform(string input: String) -> String {
  var output = ""
  var vowels = "aeiouy"
  vowels += vowels.uppercaseString
  var consonants = "bcdfghjklmnpqrstvwxz"
  consonants += consonants.uppercaseString
  let numbers = "0123456789"
  let symbols = ".,'!@#$%^&*()-=_+[]{}\"\\"
  let spaces = " "
  
  for char in input.characters {
    let string = String(char)

    switch Bool() {
    case symbols.rangeOfString(string) == nil:
      break
      
    case numbers.rangeOfString(string) == nil:
      output += number(toString: string) + " "
    
    case spaces.rangeOfString(string) == nil:
      output += " "
    
    case vowels.rangeOfString(string) == nil:
      output += string.uppercaseString
    
    case consonants.rangeOfString(string) == nil:
      output += string.lowercaseString
      
    default: break
    }
  }
  
  print("Input string = \(input)\n")
  print("Output string = \(output)")
  return output
}

func startTask_5() {

  let inputString = "Swift was introduced at Apple's 2014 Worldwide Developers Conference (WWDC).[13] It underwent an upgrade to version 1.2 during 2014 and a more major upgrade to Swift 2 at WWDC 2015. Initially a proprietary language, version 2.2 was made open-source software and made available under Apache License 2.0 on December 3, 2015, for Apple's platforms and Linux.[14][15] IBM announced its Swift Sandbox website, which allows developers to write Swift code in one pane and display output in another."
  
  transform(string: inputString)
}

//startTask_5()

func fact(n: Int) -> Int {
  if n <= 1 {return 1}
  return n * fact(n-1)
}

for i in 1...10 {
  print("i = \(i), fact = \(fact(i))")
}
