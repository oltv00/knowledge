//Tuples

let aTuple = (1, "Hello", true, 2.4)
let bTuple : (Int, String, Bool, Double) = (1, "Hello", true, 2.4)

let (number, greetings, check, deciaml) = aTuple

number
greetings
check
deciaml

let (_, _,check2, _) = aTuple
check2

let check3 = aTuple.2
check3

aTuple.0
aTuple.1
aTuple.2
aTuple.3

//--

var cTuple = (index:1, phrase:"Hello", registered:true, latency:2.4)
cTuple.index
cTuple.phrase
cTuple.registered
cTuple.latency

// change tuple's value
cTuple.index = 2

let a = (x:1, y:2)
var b = (x:2, y:3)
b = a

//--

let redColor = "red"
let greenColor = "green"
let blueColor = "blue"

let (tRedColor, tGreenColor, tBlueColor) = ("red", "green", "blue")

//--

let totalNumber = 5
let merchantName = "Alex"

print("\(totalNumber) \(merchantName)")
print((totalNumber, merchantName))
print(aTuple)

