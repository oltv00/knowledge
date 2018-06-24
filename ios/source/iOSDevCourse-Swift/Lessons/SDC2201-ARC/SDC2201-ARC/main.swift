var playground = true

class Student {
  
  //weak var teacher: Teacher?
  unowned var teacher: Teacher
  
  init(teacher: Teacher) {
    self.teacher = teacher
  }
  
  deinit {
    print("Student deallocated")
  }
}

class Teacher {
  
  var student: Student!
  var closure: ( () -> () )?
  lazy var closure2: (Bool) -> () = {
    [unowned self] (bool: Bool) in
    print(self)
  }
  
  init() {
    self.student = Student(teacher: self)
  }
  
  deinit {
    print("Teacher deallocated")
  }
}

var closure3: (() -> ())?

if playground {
  
  var teacher = Teacher()
  teacher.closure = {
    //[unowned teacher] in
    //print(teacher)
  }
  
  teacher.closure2(true)
  
  if playground {
    //var student = Student(teacher: teacher)
    //teacher.student = student
  }
  
  var student = teacher.student
  closure3 = {
    //[unowned teacher] in
    //[weak student] in
    //print(student)
  }
  
  print("exit playground")
}





var x = 10
var y = 20

class Human { var name = "a" }
var h = Human()

var closure: () -> () = { [x,y] in
  print("\(x) \(y)")
}

var closure2: Int -> Int = { [x,y,h] (a: Int) -> Int in
  print("\(x) \(y) \(h.name)")
  return a
}

closure2(1)

x = 30
y = 40
h = Human()
h.name = "b"

closure2(1)




print("end")