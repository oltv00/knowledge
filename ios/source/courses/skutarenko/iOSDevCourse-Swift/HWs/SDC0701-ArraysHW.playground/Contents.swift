/*
 1. создать массив "дни в месяцах" 12 элементов содержащих количество дней в соответствующем месяце используя цикл for и этот массив
 
 - выведите количество дней в каждом месяце (без имен месяцев)
 - используйте еще один массив с именами месяцев чтобы вывести название месяца + количество дней
 - сделайте тоже самое, но используя массив тюплов с параметрами (имя месяца, кол-во дней)
 - сделайте тоже самое, только выводите дни в обратном порядке (порядок в массиве не меняется)
 - для произвольно выбранной даты (месяц и день) посчитайте количество дней до этой даты от начала года
 */

let days = [29, 29, 31, 29, 31, 30, 29, 31, 30, 31, 30, 30]
let months = ["Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug",
                "Sep", "Oct", "Nov", "Dec"]

for day in days {
  print(day)
}

print("------")

for (i, v) in days.enumerate() {
  print("\(months[i]) have \(v) days")
}

print("------")

var daysAndMonths = [(month:String, days:Int)]()
for (i, v) in days.enumerate() {
  daysAndMonths.append((months[i], v))
}
for (i, v) in daysAndMonths.enumerate() {
  print("\(v.month) have \(v.days) days with tuple")
}

print("------")

for (i, v) in daysAndMonths.reverse().enumerate() {
  print("\(v.month) have \(v.days) days with reverse()")
}

print("------")

func daysToDate(day:Int, month:Int) -> Int {
  var res = 0
  for day in 0..<month - 1 {
    res += days[day]
  }
  return res + day
}

print("Days to 14 Nov = \(daysToDate(14, month: 11))")
print("------")

/*
 2. Сделайте первое задание к уроку номер 4 используя массивы:
 (создайте массив опшинал интов и посчитайте сумму)
 - в одном случае используйте optional binding
 - в другом forced unwrapping
 - а в третьем оператор ??
 */

let strs = ["15", "asd124", "44a", "78", "11", "asd123asd"]
var ints = [Int?]()
for str in strs {
  let optInt : Int? = Int(str)
  ints.append(optInt)
}

var sum1 = 0
for value in ints {
  if let value = value {
    sum1 += value
  }
}
print("Optional binding sum = \(sum1)")

var sum2 = 0
for val in ints {
  if val != nil {
    sum2 += val!
  }
}
print("Forced unwrapping sum = \(sum2)")

var sum3 = 0
for value in ints {
  let value = value ?? 0
  sum3 += value
}
print("?? operator sum = \(sum3)")
print("------")

/*
 3. создайте строку алфавит и пустой массив строк в цикле пройдитесь по всем символам строки попорядку, преобразовывайте каждый в строку и добавляйте в массив, причем так, чтобы на выходе получился массив с алфавитом задом-наперед
 */

let alphabet = "abcdefghijklmnopqrstuvwxyz"
var reverse = [String]()
for char in alphabet.characters.reverse() {
  reverse.append(String(char))
}
print(reverse)
