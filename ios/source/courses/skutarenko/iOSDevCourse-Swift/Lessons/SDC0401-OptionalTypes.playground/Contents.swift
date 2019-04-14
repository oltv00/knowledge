var apples : Int? = 5
//apples = nil

if apples == nil {
  print("nil apples \(apples)")
} else {
  let a = apples! + 2
}

if var number = apples {
  number += 2
}

if apples != nil {
  let a = apples! + 2
}

//--

let age = "20"
let step = 20
if let age = Int(age) {
  
  if age > step {
    print("Age:\(age) more than step:\(step)!")
  } else if age < step {
    print("Age:\(age) less than step:\(step)!")
  } else {
    print("They are equals! Age:\(age) and step:\(step)")
  }
  
} else {
  print("Age is nil, Bad enter data")
}

//--

var apples2 : Int! = nil
apples2 = 2

//just for debug
assert(apples2 != nil, "oh, no!!!")

apples2 = apples2 + 5
if apples2 != nil {
  apples2 = apples2 + 7
}

//--











