extension Int8 {
  
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

var a: Int8 = 57
a.binary()

a = 0b01111111
a.binary()
a = a &+ 1
a.binary()
a = a &- 1
a.binary()


a = 0
a = a - 1
a.binary()
a = a - 1
a.binary()


a = 0b00100001
a = a << 1
a.binary()