import UIKit

/*
 1. Посчитать количество секунд от начала года до вашего дня рождения. Игнорируйте високосный год и переходы на летнее и зимнее время. Но если хотите - не игнорируйте :)
 */

func daysInMonth(month:Int) -> Int {
  let months = [0, 29, 29, 31, 29, 31, 30, 29, 31, 30, 31, 30, 30]
  var days = 0
  for day in 0...month - 1 {
    days += months[day]
  }
  return days
}

func myBirthdayToSeconds(day:Int, month:Int) -> Int {
  var days = day
  days += daysInMonth(month)
  
  let hours = days * 24
  let minutes = hours * 60
  let seconds = minutes * 60
  
  return seconds
}

print(myBirthdayToSeconds(14, month: 11))
//print(myBirthdayToSeconds(1, month: 8))

/*
 2. Посчитайте в каком квартале вы родились
 */

func myBirthdayToQuarter(month:Int) -> Int {
  let quarters = [3, 6, 9, 12]
  for quarter in quarters {
    if month <= quarter {
      return quarters.indexOf(quarter)! + 1
    }
  }
  return 0
}

print(myBirthdayToQuarter(3))
print(myBirthdayToQuarter(6))
print(myBirthdayToQuarter(9))
print(myBirthdayToQuarter(11))

/*
 3. Создайте пять переменных типа Инт и добавьте их в выражения со сложением, вычитанием, умножением и делением. В этих выражениях каждая из переменных должна иметь при себе унарный постфиксный или префиксный оператор. Переменные могут повторяться.
 
 Убедитесь что ваши вычисления в голове или на бумаге совпадают с ответом. Обратите внимание на приоритет операций
 */

let values = [5, 11, 414, 51]

var addition = 0
var subtraction = 0
var multiplication = 1
var division = 1

for value in values {
  addition += value
  subtraction -= value
  multiplication *= value
  division /= value
}

/*
 4. Шахматная доска 8х8. Каждое значение в диапазоне 1…8. При заданных двух значениях по вертикали и горизонтали определите цвет поля. Если хотите усложнить задачу, то вместо цифр на горизонтальной оси используйте буквы a,b,c,d,e,f,g,h
 */

let chars = ["a", "b", "c", "d", "e", "f", "g", "h"]
func whatColorIn(x:Int, yString:String) -> String {
  let y = 1 + chars.indexOf(yString)!
  //if x % 2 == y % 2 {
  if (x + y) % 2 == 0 {
    return "White for x = \(x) : y = \(yString)"
  } else {
    return "Black for x = \(x) : y = \(yString)"
  }
}

for x in 1...8 {
  for y in 1...8 {
    let yString = chars[y-1]
    print(whatColorIn(x, yString: yString))
  }
}
