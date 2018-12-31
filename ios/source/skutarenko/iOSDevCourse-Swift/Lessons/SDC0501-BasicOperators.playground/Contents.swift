import UIKit

let total = ((5 + 6) - (8 * 3)) - (5 / 10)

let div = 10 / 3
let rest = 10 % 3

322342345 % 101

var small : UInt8!
small = 0b0000000011111111
small = small &+ 5

let str = "Hi" + "there!"

// >, <, >=, <=, ==, !=, ===, !==
let a = Int(arc4random_uniform(100))
let b = Int(arc4random_uniform(100))
if a > b {
  print("a:\(a) > b:\(b)")
} else {
  print("a:\(a) < b:\(b)")
}

let c = a > b ? a : b

//--

let text = String(c) + ""

// forced unwrapping
let intVar = Int(text)
if intVar != nil {
  print(intVar!)
} else {
  print("intVar is nill")
}

// optional binding
if let opt = intVar {
  print(opt)
} else {
  print("opt is nil")
}

// ?? operator
let opt2 = intVar ?? 0

//--

var sum = 5
sum = sum + 1
sum += 1

let good = true
let bad = !good

true && true
true && false
false && true
false && false

true || true
true || false
false || true
false || false

//--

0...5
0..<5

var sum2 = 0
for i in 0...100 {
  sum2 += i
  if i % 2 == 0 {
    sum2 /= 2
  }
}

























