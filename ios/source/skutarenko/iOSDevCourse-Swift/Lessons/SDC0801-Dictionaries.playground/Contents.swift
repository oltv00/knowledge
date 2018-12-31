/*
 let dict = ["kCar" : "car", "kMan" : "man"]
let dict2 : [Int:String] = [0 : "car", 1 : "man"]
let dict3 : Dictionary<String, Double> = [:]
let dict4 = [String:String]()

dict["kMan"]
dict2[1]

//--

var dict5 = ["kCar" : "car", "kMan" : "man"]
dict5.count
dict5.isEmpty
dict5["kComp"] = "comp"
print(dict5)

dict5.keys
dict5.values

dict5["kComp"] = "mac"
print(dict5)
dict5.updateValue("comp", forKey: "kComp")
print(dict5)

let comp : String? = dict5["kComp"]
if let comp = dict5["kComp2"] {
  print("\(comp)")
} else {
  print("no value for key kComp2")
}

dict5.removeValueForKey("kMan")
print(dict5)

dict5 = [:]
dict5.isEmpty
print
*/
//--

var dict6 = ["kCar" : "car", "kMan" : "man"]
dict6["kComp"] = "mac"

for key in dict6.keys {
  print("key = \(key), value = \(dict6[key])")
}

for (key, value) in dict6 {
  print("key = \(key), value = \(value)")
}


