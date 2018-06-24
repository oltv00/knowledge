// SWIFT Марафон. Урок 13: Классы и Структуры

// INPUT DATA
import Foundation

let firstNames = ["Tran", "Lenore", "Bud", "Fredda", "Katrice",
                  "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert"]

let lastNames = ["Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
                 "Homan", "Starns", "Oldham", "Yocum", "Mancia"]

func randomBirthday() -> String {
  let day = 1 + arc4random_uniform(30)
  let month = 1 + arc4random_uniform(12)
  let year = 1980 + arc4random_uniform(15)
  return String("\(day).\(month).\(year)")
}

func randomScore() -> Float {
  return 2 + Float(arc4random_uniform(3000)) / 1000
}

/*1. Создайте структуру студент. Добавьте свойства: имя, фамилия, год рождения, средний бал. Создайте несколько экземпляров этой структуры и заполните их данными. Положите их всех в массив (журнал).*/

struct Student {
  var firstName: String
  var lastName: String
  var birthday: String
  var score: Float
  
  func description() -> String {
    return "\(firstName) \(lastName), birthday: \(birthday), score: \(score)"
  }
}

var students = [Student]()

func initStudents() {
  let studentsCount = 10
  for _ in 0..<studentsCount {
    let firstName = firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
    let lastName = lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
    let birthday = randomBirthday()
    let score = randomScore()
    let student = Student(firstName: firstName,
                          lastName: lastName,
                          birthday: birthday,
                          score: score)
    students.append(student)
  }
}

initStudents()

/*2. Напишите функцию, которая принимает массив студентов и выводит в консоль данные каждого. Перед выводом каждого студента добавляйте порядковый номер в “журнале”, начиная с 1.*/

func description(students:[Student]) {
  var index = 1
  for student in students {
    print("\(index). \(student.description())")
    index += 1
  }
}
//description(students)

/*3. С помощью функции sorted отсортируйте массив по среднему баллу, по убыванию и распечатайте “журнал”.*/
func task_3() {
  let sortedByScore = students.sort { (student1, student2) -> Bool in
    student1.score > student2.score
  }
description(sortedByScore)
}
//task_3()

/*4. Отсортируйте теперь массив по фамилии (по возрастанию), причем если фамилии одинаковые, а вы сделайте так чтобы такое произошло, то сравниваются по имени. Распечатайте “журнал”.*/

func task_4() {
  let sortedByLastName = students.sort { (student1, student2) -> Bool in
    if student1.lastName < student2.lastName {
      return true
    } else if student1.lastName == student2.lastName {
      if student1.firstName < student2.firstName {
        return true
      }
    }
    return false
  }
  description(sortedByLastName)
}

//task_4()

/*5. Создайте переменную и присвойте ей ваш существующий массив. Измените в нем данные всех студентов. Изменится ли первый массив? Распечатайте оба массива.*/

func task_5() {
  let journal = students
  for student in journal {
    var student = student
    student.firstName = "MY NEW NAME"
  }
  
  print("\t\t\t-----===== JOURNAL =====-----")
  description(journal)
  
  print("\n\t\t\t-----===== STUDENTS =====-----")
  description(students)
}

//task_5()

/*6. Теперь проделайте все тоже самое, но не для структуры Студент, а для класса. Какой результат в 5м задании? Что изменилось и почему?*/



/*007. Уровень супермен
 Выполните задание шахмат из урока по энумам используя структуры либо классы*/

