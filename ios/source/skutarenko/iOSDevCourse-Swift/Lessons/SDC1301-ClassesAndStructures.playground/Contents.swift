func test_1(){
  let student1 = (name: "Alex", age: 20)
  let student2 = (name: "Bob", age: 22)
  
  student1.name
  student2.age
  
  let student3 = (nam: "Sam", ag: 23)
  student3.nam
  student3.ag
}
//test_1()

// ---

class StudentClass {
  var name : String
  var age : Int
  
  init() {
    name = "No name"
    age = 20
  }
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  
  func description(ivarName: String) {
    print("I'AM CLASS: \(ivarName) - Name: \(name), Age: \(age)")
  }
}

struct StudentStruct {
  var name : String
  var age : Int
  
  func description(ivarName: String) {
    print("I'AM STRUCT: \(ivarName) - Name: \(name), Age: \(age)")
  }
}

func addOneYear(student:StudentClass) {
  student.age += 1
}

func addOneYear(inout student:StudentStruct) {
  student.age += 1
}

// ---

// CLASS
let stClass1 = StudentClass(name: "Bob", age: 18)
stClass1.description("stClass1")

let stClass2 = stClass1
stClass2.name = "Alex"
stClass2.age = 28
stClass1.description("stClass1")
stClass2.description("stClass2")

addOneYear(stClass2)
stClass2.description("stClass2")

var arrayClasses = [stClass2]
arrayClasses[0].age = 50
arrayClasses[0].description("stClass2")
stClass2.description("stClass2")

// STRUCT

var stStruct1 = StudentStruct(name: "Sam", age: 24)
stStruct1.description("stStruct1")

var stStruct2 = stStruct1
stStruct2.name = "Samuel"
stStruct2.age = 25
stStruct1.description("stStruct1")
stStruct2.description("stStruct2")

addOneYear(&stStruct2)
stStruct2.description("stStruct2")

addOneYear(&stStruct2)
stStruct2.description("stStruct2")

var arrayStructs = [stStruct2]
arrayStructs[0].age = 50
arrayStructs[0].description("stStruct2")
stStruct2.description("stStruct2")

