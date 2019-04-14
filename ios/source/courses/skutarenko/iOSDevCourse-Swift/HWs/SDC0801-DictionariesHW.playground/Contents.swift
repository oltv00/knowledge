/*
 1. Создайте дикшинари как журнал студентов, где имя и фамилия студента это ключ, а оценка за контрольную значение. Некоторым студентам повысьте оценки - они пересдали. Потом добавьте парочку студентов, так как их только что перевели к вам в группу. А потом несколько удалите, так как они от вас ушли :(
 
 После всех этих перетрубаций посчитайте общий бал группы и средний бал
 */

import UIKit

// data
let firstNames = ["Tran", "Lenore", "Bud", "Fredda", "Katrice",
                  "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert"]

let lastNames = ["Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
                 "Homan", "Starns", "Oldham", "Yocum", "Mancia"]

// helper functions
func randomScore() -> Float {
  return 2 + Float(arc4random_uniform(3000)) / 1000
}

// create students journal
var students = [String:Float]()
func createJournalWithCount(count:Int) {
  for _ in 0..<count {
    let n = firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
    let f = lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
    let score = randomScore()
    students["\(n) \(f)"] = score
  }
}

// to enable students to retake
func retake(student:String, score:Float) -> Float {
  var newScore = randomScore()
  print("\(student) old score = \(score) new score = \(newScore)")
  if newScore < score {
    newScore = retake(student, score: newScore)
  }
  return newScore
}

// add new students
func addNewStudent(name:String, score:Float) {
  students[name] = score
}

// check students score
func restrictionsToScore(score:Float) {
  for (k, v) in students {
    if v < score {
      let newScore = retake(k, score: v)
      students[k] = newScore
      print("\(k) assigned new score = \(newScore)")
      print("----------")
    }
  }
}

// remove students with bad score
func removeStudentsWithBadScore(badScore:Float) {
  for (k, v) in students {
    if v < badScore {
      print("\(k) have bad score = \(v)")
      print("----------")
      students.removeValueForKey(k)
    }
  }
}

// print journal
func printJournal() {
  for (k, v) in students {
    print("\(k) have score = \(v)")
  }
}

// setup overall score
func overallScore() -> Float {
  var overall : Float = 0.0
  for value in students.values {
    overall += value
  }
  return overall
}

// setup average score
func averageScore() -> Float {
  var average : Float = 0.0
  for value in students.values {
    average += value
  }
  return average / Float(students.count)
}

func startTask_1() {
  createJournalWithCount(20)
  restrictionsToScore(3.5)
  removeStudentsWithBadScore(3)
  
  addNewStudent("John Simon", score: randomScore())
  addNewStudent("Jack Simon", score: randomScore())
  
  printJournal()
  
  print("Overall score = \(overallScore())")
  print("Average score = \(averageScore())")
}

//startTask_1()

/*
 2. Создать дикшинари дни в месяцах, где месяц это ключ, а количество дней - значение.
 В цикле выведите ключ-значение попарно, причем один раз выведите через тюплы, а другой раз пройдитесь по массиву ключей и для каждого из них доставайте значения.
 */

//data
let days = [29, 29, 31, 29, 31, 30, 29, 31, 30, 31, 30, 30]
let months = ["Jan", "Feb", "Mar", "Apr",
              "May", "Jun", "Jul", "Aug",
              "Sep", "Oct", "Nov", "Dec"]

// create dictionary of monts
var daysInMonths = [String:Int]()
func createDaysInMonths() {
  if days.count != months.count {
    print("Error! Count of both arrays must be equal!")
  } else {
    
    for (i, v) in days.enumerate() {
      daysInMonths[months[i]] = v
    }
  }
}

func printViaTuples() {
  for (k, v) in daysInMonths {
    print("key:\(k) - value:\(v)")
  }
  print("----------")
}

func printViaKeyValue() {
  for key in daysInMonths.keys {
    print("key:\(key) - value:\(daysInMonths[key])")
  }
  print("----------")
}

func startTask_2() {
  createDaysInMonths()
  printViaTuples()
  printViaKeyValue()
}

//startTask_2()

/*
 3. Создать дикшинари , в которой ключ это адрес шахматной клетки (пример: a5, b3, g8), а значение это Bool. Если у клетки белый цвет, то значение true, а если черный - false. Выведите дикшинари в печать и убедитесь что все правильно.
 
 Рекомендация: постарайтесь все сделать используя вложенный цикл (объяснение в уроке).
 */

var chessBoard = [String:Bool]()
public let chessSize = 8
let chars = ["a", "b", "c", "d", "e", "f", "g", "h"]

//func createChessBoardDictionary() {
//  for i in 0..<chessSize {
//    for j in 0..<chessSize {
//      let key = "\(chars[j])\(i+1)"
//      if i % 2 == j % 2 {
//        chessBoard[key] = false
//      } else {
//        chessBoard[key] = true
//      }
//    }
//  }
//}

func createChessBoardDictionary() {
  for i in 0..<chessSize {
    for j in 0..<chessSize {
      chessBoard["\(chars[j])\(i+1)"] = (i % 2 != j % 2)
    }
  }
}

func printChessBoard() {
  for (k, v) in chessBoard {
    print("key:\(k) value:\(v)")
  }
}

func startTask_3() {
  createChessBoardDictionary()
  printChessBoard()
}

//startTask_3()
