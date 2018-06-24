import Foundation

/* Добавить студенту property «Дата рождения» (пусть это будет еще одна структура, содержащая день, месяц, год) и два computed property: первое — вычисляющее его возраст, второе — вычисляющее, сколько лет он учился (считать, что он учился в школе с 6 лет, если студенту меньше 6 лет — возвращать 0) */

func date(day: Int, month: Int, year: Int) -> (years:Int, months:Int, days:Int) {
  
  let calendar = NSCalendar.currentCalendar()
  let comps = NSDateComponents.init()
  comps.day = day; comps.month = month; comps.year = year
  let date = calendar.dateFromComponents(comps)!
  
  let diffComps = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date, toDate: NSDate.init(), options: NSCalendarOptions.init(rawValue: 0))
  
  let result = (diffComps.year, diffComps.month, diffComps.day)
  return result
}

struct Student {
  func descrtion() {
    print("firstname = \(firstName)",
          "lastname = \(lastName)",
          "fullname = \(fullName)")
  }
  var firstName: String { didSet { firstName = firstName.capitalizedString } }
  var lastName: String { didSet { lastName = lastName.capitalizedString } }
  var fullName: String {
    get {return firstName + " " + lastName}
    set {
      let words = newValue.componentsSeparatedByString(" ")
      if words.count > 0 {firstName = words[0]}
      if words.count > 1 {lastName = words[1]}
    }
  }
  
  var birthday: Birthday
}

struct Birthday {
  var day: Int
  var month: Int
  var year: Int
  
  var howOld: String {
    get {
      let old = date(day, month: month, year: year)
      return "\(old.years) - years, \(old.months) - months, \(old.days) - days"
    }
  }
  
  var howLearn: Int {
    get {
      let old = date(day, month: month, year: year)
      if old.years < 6 {return 0}
      let learn = old.years - 6
      return learn
    }
  }
}

let student = Student(firstName: "John", lastName: "Mong", birthday: Birthday(day: 14, month: 11, year: 1991))

student.descrtion()
print("Birthday: " + student.birthday.howOld)
print("Learn time: \(student.birthday.howLearn) years")






