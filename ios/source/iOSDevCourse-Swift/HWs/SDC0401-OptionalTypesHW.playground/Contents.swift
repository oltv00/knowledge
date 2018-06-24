/*
 1. Создать пять строковых констант
 Одни константы это только цифры, другие содержат еще и буквы
 Найти сумму всех этих констант приведя их к Int
 (Используйте и optional binding и forced unwrapping)
 */

print("---=== 1 TASK ===---")

let a = "5"
let b = "7asd"
let c = "10"
let d = "20withChars"
let f = "15ff"
let array = [a,b,c,d,f]
var sum = 0

for str : String in array {
  if let intStr = Int(str) {
    sum += intStr
    print("Now sum is = \(sum)")
  } else {
    print("\(str) is not Int type")
  }
}

print("Result sum is \(sum)")
print("--------------------\n")

/*
 2. С сервера к нам приходит тюпл с тремя параметрами:
 statusCode, message, errorMessage (число, строка и строка)
 в этом тюпле statusCode всегда содержит данные, но сама строка приходит только в одном поле
 если statusCode от 200 до 300 исключительно, то выводите message,
 в противном случает выводите errorMessage
 После этого проделайте тоже самое только без участия statusCode
 */

print("---=== 2 TASK ===---")

let statusCode1 = 199
var message1 : String?
var error1 : String?

if statusCode1 >= 200 && statusCode1 < 300 {
  message1 = "[RESPONSE_OBJECT]"
} else {
  error1 = "error, status code: \(statusCode1)"
}

let response1 = ["statusCode" : String(statusCode1),
                 "message"    : message1,
                 "error"      : error1]
print(response1)

var message2 : String?
var error2 : String?

message2 = "[RESPONSE_OBJECT]"
error2 = "error, to many requests per second"

if error2 != nil {
  print("Error = \(error2!)")
} else {
  print("Response = \(message2!)")
}

print("--------------------\n")

/*
 3. Создайте 5 тюплов с тремя параметрами:
 имя, номер машины, оценка за контрольную
 при создании этих тюплов не должно быть никаких данных
 после создания каждому студенту установите имя
 некоторым установите номер машины
 некоторым установите результат контрольной
 выведите в консоль:
 
 - имена студента
 - есть ли у него машина
 - если да, то какой номер
 - был ли на контрольной
 - если да, то какая оценка
 */

print("---=== 3 TASK ===---")

var student1 : (name:String!, carNumber:Int?, score:Float?)
var student2 : (name:String!, carNumber:Int?, score:Float?)
var student3 : (name:String!, carNumber:Int?, score:Float?)
var student4 : (name:String!, carNumber:Int?, score:Float?)
var student5 : (name:String!, carNumber:Int?, score:Float?)

student1.name = "John"
student2.name = "Fred"
student3.name = "Ketty"
student4.name = "Sibastian"
student5.name = "Alfred"

student1.carNumber = 42662
//student2.carNumber = nil
student3.carNumber = 85727
//student4.carNumber = nil
student5.carNumber = 27482

//student1.score = nil
student2.score = 3.2
//student3.score = nil
student4.score = 3.8
student5.score = 4.2

let students = [student1, student2, student3, student4, student5]

for student in students {
  print("Student name: \(student.name)")
  
  if let car = student.carNumber {
    print("\(student.name) have a car \(car)")
  } else {
    print("\(student.name) have not a car")
  }
  
  if let score = student.score {
    print("\(student.name) have a score \(score)\n")
  } else {
    print("\(student.name) have not a score\n")
  }
}

print("--------------------\n")