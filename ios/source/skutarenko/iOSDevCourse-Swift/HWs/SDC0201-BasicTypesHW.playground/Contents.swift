// 1. Выведите в консоль минимальные и максимальные значения базовых типов.

Int.max
Int.min
UInt.max
UInt.min

Int8.max
Int8.min
UInt8.max
UInt8.min

Int16.max
Int16.min
UInt16.max
UInt16.min

Int32.max
Int32.min
UInt32.max
UInt32.min

Int64.max
Int64.min
UInt64.max
UInt64.min

// 2. Создайте 3 константы с типами Int, Float и Double
// Создайте другие 3 константы, тех же типов: Int, Float и Double.
// Каждая из них это сумма первых трех, но со своим типом.

let intVal = 5
let floatVal : Float = 6.3
let doubleVal = 7.8

let intSum = intVal + Int(floatVal) + Int(doubleVal)
let intSumWithInt = Int(Double(intVal) + Double(floatVal) + doubleVal)
let floatSum = Float(intVal) + floatVal + Float(doubleVal)
let doubleSum = Double(intVal) + Double(floatVal) + doubleVal

// 3. Сравните Int результат суммы с Double и выведите отчет в консоль

print("if with args \(Double(intSumWithInt)) and \(doubleSum)")
if Double(intSumWithInt) > doubleSum {
  print("\(intSumWithInt) is more!")
} else {
  print("\(doubleSum) is more!")
}
