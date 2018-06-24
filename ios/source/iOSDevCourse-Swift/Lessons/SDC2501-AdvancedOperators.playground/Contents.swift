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

var a: UInt8 = 57
a.binary()


(10 as UInt8).binary()
(4 as UInt8).binary()
(10 - 4).binary()


a.binary()
(5 as UInt8).binary()
(a + 5).binary()


a.binary()
a * 2
a << 1

a * 4
a << 2
a.binary()

a.binary()
a / 2
a >> 1

a / 4
a >> 2
a.binary()


a = a &* 8
a.binary()

a = 0b11111111
a = a &+ 1

a = 0b00000000
a = a &- 1







