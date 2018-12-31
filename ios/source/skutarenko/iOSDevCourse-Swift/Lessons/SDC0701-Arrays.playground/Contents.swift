let constArray = ["a", "b", "c", "d"]
constArray.count

var array = [String]()
if array.isEmpty {
  print("array is empty")
}

array += constArray
array += ["ef"]
array.append("e")

var array2 = array

array
array2

array2[0] = ""

// WAS COPIED!!!
array
array2

array[1...4] = ["0"]
array
array.insert("-", atIndex: 2)
array
array.removeAtIndex(2)
array

//--
let test = [Int](count: 10, repeatedValue: 100)

let money = [100, 1, 5, 20, 1, 50, 1, 1, 20, 1]
var sum = 0

for index in 0..<money.count {
  sum += money[index]
}
sum
sum = 0

for i in money {
  sum += i
}
sum
sum = 0

for (index, value) in money.enumerate() {
  print("index = \(index) : value = \(money[index])")
  sum += value
}
sum









