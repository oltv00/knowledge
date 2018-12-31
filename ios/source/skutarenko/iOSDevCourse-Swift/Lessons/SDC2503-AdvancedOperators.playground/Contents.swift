extension UInt8 {
  
  func binary() -> String {
    var result = ""
    for i in 0..<8 {
      let mask = 1 << i
      let set = Int(self) & mask != 0
      result = (set ? "1" : "0") + result
    }
    return result
  }
}

0b11111111
0xff

var a: UInt8 = 0b00110011
var b: UInt8 = 0b11100001

a.binary()
b.binary()
(a | b).binary() // as +


a.binary()
b.binary()
(a & b).binary() // as *


a.binary()
b.binary()
(a ^ b).binary()


a.binary()
(~a).binary()


// GET
b = 0b00010000
a.binary()
b.binary()
(a & b).binary()

if a & b == b {
  "YES"
} else {
  "NO"
}


// SET
b = 0b00000100
a.binary()
b.binary()
(a | b).binary()


// Inverse
b = 0b00000110
a.binary()
b.binary()
(a ^ b).binary()


// dropping bits
b = 0b00010000
a.binary()
(~b).binary()
(a & ~b).binary()


// --

enum CheckList: UInt8 {
  case Bread =    0b00000001
  case Chicken =  0b00000010
  case Apples =   0b00000100
  case Pears =    0b00001000
}

let checkList: UInt8 = 0b00001001

let bread = checkList & CheckList.Bread.rawValue
bread.binary()

let chicken = checkList & CheckList.Chicken.rawValue
chicken.binary()

let pears = checkList & CheckList.Pears.rawValue
pears.binary()






