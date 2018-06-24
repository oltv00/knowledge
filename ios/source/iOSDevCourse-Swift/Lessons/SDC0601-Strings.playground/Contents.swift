var str = String()
str += "a"

// value type
var a = 5
var b = a

// b was copied
a += 1
b

//--

var str1 = "a"
var str2 = str1

str1
str2

str1 = "b"

// str2 was copied
str1
str2

//--

var str3 = "abc"
str3.isEmpty

let char1 : Character = "x"

let str4 = "Hello World!"
String(str4.characters.reverse())

for c in "Hello World!".characters {
  //print(c)
}

var str5 = "a"
var char : Character = "b"
str5.append(char)

import Foundation
(str5 as NSString).length
NSString(string:"with love from objc")

//--

let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
let aAcute : Character = "a\u{301}"

let fun : Character = "ъ"
let funAcute : Character = "ъ\u{301}"
let funAcuteCircled : Character = "ъ\u{301}\u{20dd}"

let funStringAcuteCircled = "what is this? -> \(funAcuteCircled)"
funStringAcuteCircled.characters.count
(funStringAcuteCircled as NSString).length

let funs = [fun, funAcute, funAcuteCircled]
for funStr in funs {
  let funString = String(funStr)
  print(".characters.count = \(funString) = \(funString.characters.count)")
  print("(as NSString).length = \(funString) = \((funString as NSString).length)")
}

let str6 = "abc"
if str6 == "abc" {
  print ("equals")
} else {
  print("not equal")
}

let funString = String(funAcuteCircled)
funStringAcuteCircled.hasPrefix("what")
funStringAcuteCircled.hasSuffix("ъ\u{301}")
funStringAcuteCircled.hasSuffix("ъ\u{301}\u{20dd}")
