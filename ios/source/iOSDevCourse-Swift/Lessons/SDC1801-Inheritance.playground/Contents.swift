
// final - daughter class can't overriding
/* final */ class Human {
  
  /* final */ var firstName: String = ""
  var lastName: String = ""
  
  var fullName: String {
    return firstName + " " + lastName
  }
  
  /* final */ func sayHello() -> String {
    return "Hello"
  }
}

class SmartHuman: Human {
  
}

class Student: SmartHuman {
  override func sayHello() -> String {
    return super.sayHello() + " my friend"
  }
}

class Kid: Human {
  override func sayHello() -> String {
    return "Agu"
  }
  
  override var fullName: String {
    return firstName
  }
  
  override var firstName: String {
    set {
      super.firstName = newValue + " :)"
    }
    get {
      return super.firstName
    }
  }
  
  override var lastName: String {
    didSet {
      print("new value " + self.lastName)
    }
  }
}

let human = Human()
human.firstName = "Alex"
human.lastName = "Skutarenko"
human.fullName
human.sayHello()

let student = Student()
student.firstName = "Max"
student.lastName = "Mix"
student.fullName
student.sayHello()

let kid = Kid()
kid.firstName = "Kid"
kid.lastName = "12345"
kid.fullName
kid.sayHello()

let array = [human, student, kid]
for obj in array {
  print(obj.fullName)
}



