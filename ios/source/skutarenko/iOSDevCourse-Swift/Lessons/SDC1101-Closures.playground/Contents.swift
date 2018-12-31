let numbers = [2,5,6,11,41,143,55,2,66,123,890,67,3,1]

func filterArray(array: [Int], calc: (Int) -> Bool) -> [Int] {
  var result = [Int]()
  for index in array {
    if calc(index) {result.append(index)}
  }
  return result
}

func compare(index: Int) -> Bool {
  return index % 2 == 0
}

filterArray(numbers, calc: compare)

// manual entry
filterArray(numbers, calc: {(index: Int) -> Bool in
  return index % 2 == 1
})

// auto entry
filterArray(numbers) { (i: Int) -> Bool in
  return i % 2 == 0
}

// -----

filterArray(numbers) { (i) -> Bool in i < 10 }
filterArray(numbers) { i in i % 2 == 1 }
filterArray(numbers) { $0 % 3 == 0 }

// -----

let array = [1,2,3]
let a =
filterArray(numbers) { value in
  for include in array {
    if include == value {
      return true
    }
  }
  return false
}

// -----

import Foundation
var input = [Int]()
var filter = [Int]()
var iterationsArray = 0

for _ in 0..<25 {
  input.append(Int(arc4random_uniform(100)))
  filter.append(Int(arc4random_uniform(100)))
}

let resArray =
filterArray(input) { (value) -> Bool in
  for include in filter {
    iterationsArray += 1
    if include == value {
      return true
    }
  }
  return false
}

iterationsArray


var filterDict = [Int:Bool]()
var iterationsDict = 0

for value in filter {
  filterDict[value] = true
}

let resDict =
filterArray(input) { (value) -> Bool in
  iterationsDict += 1
  return filterDict[value] != nil
}

iterationsDict







