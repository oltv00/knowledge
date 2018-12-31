extension Int {
  var isNegative: Bool {
    return self < 0
  }
  
  var isPositive: Bool {
    return self > 0
  }
  
  var bool: Bool {
    return self != 0
  }
  
  var length: Int {
    return String(self).characters.count
  }
  
  subscript(index: Int) -> Int? {
    get {
      let string = String(self)
      let result = string[index]
      if result != nil { return Int(result!) }
      return nil
    }
    
    set {
      var string = String(self)
      if let idx = string.indexByInt(index) {
        if let newValue = newValue {
          let c = Character(String(newValue))
          string.removeAtIndex(idx)
          string.insert(c, atIndex: idx)
          
          if let newInt = Int(string) {
            self = newInt
          }
        }
      }
    }
  }
}

extension String {
  subscript(index: Int) -> String? {
    if index <= 0 { return nil }
    if index > self.characters.count { return nil }
    
    if let idx = self.indexByInt(index) {
      return String(self[idx])
    }
    
    return nil
  }
  
  func indexByInt(index: Int) -> Index? {
    if index <= 0 { return nil }
    if index > self.characters.count { return nil }
    return self.startIndex.advancedBy(index - 1)
  }
  
  subscript(range: Range<Int>) -> String {
    get {
      
      // DRY
      let start = self.startIndex.advancedBy(range.startIndex)
      let end = self.startIndex.advancedBy(range.endIndex)
      
      var newString = ""
      for index in start..<end {
        newString.append(self[index])
      }
      return newString
    }
    
    set {
      
      // DRY
      let start = self.startIndex.advancedBy(range.startIndex)
      let end = self.startIndex.advancedBy(range.endIndex)
      self.replaceRange(start..<end, with: newValue)
    }
  }
  
  func truncate(index: Int) -> String {
    if index >= self.characters.count { return self }
    let endIndex = self.startIndex.advancedBy(index)
    var newString = ""
    for index in self.startIndex..<endIndex {
      newString.append(self[index])
    }
    newString += "..."
    return newString
  }
}

let a = -1
a.isNegative
a.isPositive
a.bool

525.length
15125125.length

let b = 8245

b[0]
b[1] // 8
b[3] // 4

let c = 25
c[1]
c[2]
c[3]

var d = 123456789
d[1] = 2
d[2] = 3
d

var str = "Hello, World!"
str[0...4]
str[0...4] = "Goodbye"
str



let s = "Hi hi hi"

s.truncate(1)
s.truncate(4) // Hi h...
s.truncate(7)
s.truncate(8)
s.truncate(10) // Hi hi hi
