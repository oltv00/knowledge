var age = 51

//objc style
if age == 21 {
  // ...
} else if age == 2 {
  // ...
} else {
  // ...
}

//objc style
switch age {
case 21:
  //...
  break
default:
  //...
  break
}

mainLoop: for _ in 0...100 {
  for i in 0..<20 {
    if i == 10 {
      break mainLoop
    }
    print(i)
  }
}

age = 51
switch age {
case 0...16:
  print("School")
  
case 17...21:
  print("Student")
  
case 22...50:
  break
  
case 51, 56:
  print("age now is 51 or 56!")
  
default: break
}


var name = "Alex"
switch name {
case "Alex" where age < 50:
  print("Hi Buddy!")
case "Alex" where age >= 50:
  print("I don't know you")
  
default:
  break
}

// optional binding
var optionalA : Int? = 5
if let optionalA = optionalA {
  print("a: \(optionalA) != nil")
}

// value binding
age = 68
switch (name, age) {
case ("Alex", 60): print("Hi Alex 60")
case ("Alex", 59): print("Hi Alex 59")
  
case (_, let number) where number >= 65 && number <= 70:
  print("Hi \(name), old man!")
  
case ("Alex", _): print("Hi Alex")
default: break
}

let point = (5,25)
switch point {
case let (x,y) where x == y:
  print("x == y")
case let (x,y) where x == -y:
  print("x == -y")
case let (_,y) where y < 0:
  print("y < 0")
  
default:
  print("default")
  break
}

let array : [CustomStringConvertible] = [5, 5.4, Float(5.4)]
print(array)

switch array[1] {
case _ as Int: print("Int")
case _ as Float: print("Float")
case _ as Double: print("Double")
  
default: break
}














