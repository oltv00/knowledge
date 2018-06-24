extension Int {
  var isEven: Bool {
    return self % 2 == 0
  }
  
  var isOdd: Bool {
    return !isEven
  }
  
  enum EvenOrOdd {
    case Even, Odd
  }
  
  var evenOrOdd: EvenOrOdd {
    return isEven ? .Even : .Odd
  }
  
  func pow(value: Int) -> Int {
    var res = self
    for _ in 1..<value {
      res *= self
    }
    return res
  }
  
  mutating func powTo(value: Int) {
    self = pow(value)
  }
  
  var binaryString: String {
    var result = ""
    for i in 0..<8 {
      result = String(self & (1 << i) > 0) + result
    }
    return result
  }
}

extension String {
  init(_ value: Bool) {
    self.init(value ? 1 : 0)
  }
  
  subscript(start: Int, length: Int) -> String {
    let start = self.startIndex.advancedBy(start)
    let end = start.advancedBy(length)
    return self[start..<end]
  }
}

extension Int.EvenOrOdd {
  var string: String {
    switch self {
    case .Even: return "even"
    case .Odd: return "odd"
    }
  }
}

let a = 5
if a % 2 == 0 {
  print("\(a) is an even")
} else {
  print("\(a) is odd")
}

var b = 5
b.isEven

b.evenOrOdd
b.evenOrOdd.string

b.pow(3)
b.powTo(4)
b

b = 255
b.binaryString

let s = "Hello, World!"

let start = s.startIndex
let end = s.startIndex.advancedBy(5)
let range = start..<end
s[range]

s
s[0, 5]

