import Foundation

struct Student {
  func description() {print("\(firstName) \(lastName) - \(fullName)")}
  
  var firstName : String {
    // Stored Properties
    willSet(newFirstName) /* newValue */ {
      print("will set " + newFirstName + " instead of " + firstName)
    }
    didSet(oldFirstName) /* oldValue */ {
      print("did set " + firstName + " instead of " + oldFirstName)
      firstName = firstName.capitalizedString
    }
  }
  
  var lastName : String {
    // Stored Properties
    didSet { lastName = lastName.capitalizedString }
  }
  
  var fullName : String {
    // Computed Properties
    get {return firstName + " " + lastName}
    set {
      print("fullName wants to be set to " + newValue)
      let words = newValue.componentsSeparatedByString(" ")
      if words.count > 0 { firstName = words[0] }
      if words.count > 1 { lastName = words[1] }
    }
  }
}

var student = Student(firstName: "Alex", lastName: "Skutarenko")
student.description()

student.firstName = "Bob"
student.description()

student.fullName = "vasya pupkin"
student.description()
