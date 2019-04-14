/*
 1. Выполните задание #1 урока о базовых операторах: http://vk.com/topic-58860049_31536965 только вместо forced unwrapping и optional binding используйте оператор ??
 Когда посчитаете сумму, то представьте свое выражение в виде строки например: 5 + nil + 2 + 3 + nil = 10 но в первом случае используйте интерполяцию строк, а во втором конкатенацию
 */

let a = "50" ;
let b = "123d" ;
let c = "747"
let d = "10zzz"
let e = "15"

let aInt : Int! = Int(a) ?? nil
let bInt : Int! = Int(b) ?? nil
let cInt : Int! = Int(c) ?? nil
let dInt : Int! = Int(d) ?? nil
let eInt : Int! = Int(e) ?? nil
let ints = [aInt, bInt, cInt, dInt, eInt]

var sum = 0
for int in ints {
  if let intVar = int {
    sum += intVar
  }
}
print("Sum = \(sum)")

let aStr = String(aInt)
let bStr = String(bInt)
let cStr = String(cInt)
let dStr = String(dInt)
let eStr = String(eInt)

let task1 = "\(aInt) + \(bInt) + \(cInt) = \(dInt) + \(eInt)"
let task2 = aStr + " + " + bStr + " + " + cStr + " + " + dStr + " + " + eStr

/*
 2. Поиграйтесь с юникодом и создайте строку из 5 самых классных по вашему мнению символов, можно использовать составные символы. Посчитайте длину строки методом SWIFT и Obj-C
 */

let symbs = "\u{1234}"

import Foundation
let min : UInt32 = 0
let max : UInt32 = 0x1FFFF
var str = ""
for i in 0..<5 {
  let rand : UInt32 = arc4random_uniform(max)
  let unicode = UnicodeScalar.init(rand)
  let char = Character.init(unicode)
  str.append(char)
  str = str.stringByAppendingString(String(char))
}
print(str)
print("swift count = \(str.characters.count)")
print("objc length = \((str as NSString).length)")

/*
 3. Создайте строку английский алфавит, все буквы малые от a до z задайте константу - один из символов этого алфавита
 Используя цикл for определите под каким индексов в строке находится этот символ
 */

let alphabet = "abcdefghijklmnopqrstuvwxyz"
let const : Character = "s"

// 1 decision
alphabet.characters.indexOf(const)

// 2 decision
for char in alphabet.characters {
  if char == const {
    let idx = alphabet.characters.indexOf(char)
  }
}


















