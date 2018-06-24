
func calculateMoney(inWallet wallet: [Int], withType type: Int? = nil) -> (total:Int, count:Int) {
  
  var wallet = wallet
  wallet.append(1000)
  
  var sum = 0
  var count = 0
  
  for value in wallet {
    if type == nil || value == type! {
      sum += value
      count += 1
    }
  }
  
  print("sum = \(sum), count = \(count)")
  return (sum, count)
}

func calculateMoney(inSequence range: Int...) -> Int {
  var sum = 0
  for value in range {
    sum += value
  }
  return sum
}

let wallet = [100, 5, 1, 5, 5, 20, 50, 100, 1, 1]

let (money, count) = calculateMoney(inWallet: wallet, withType: 100)
let (money2, count2) = calculateMoney(inWallet: wallet, withType: nil)
let (money3, count3) = calculateMoney(inWallet: wallet)

calculateMoney(inWallet: wallet).total
calculateMoney(inWallet: wallet).count
// do somth with money

calculateMoney(inSequence: 5,10,15,100,20,25,50,11)

// -----
func sayHi() -> () {
  print("hi")
}

let hi /*: () -> ()*/ = sayHi


// -----
func sayPhrase(phrase: String) -> Int? {
  print(phrase)
  return 0
}

sayPhrase("aaa")

let phrase /*: (String) -> (Int?)*/ = sayPhrase
phrase("bbb")

// -----
func doSomething(whatToDo:()->()) {
  whatToDo()
}

func whatToDo() -> ()->() {
  
  func printSomething() {
    print("printSomething in whatToDo")
  }
  
  return printSomething
}

doSomething(hi)

let iShouldDoThis = whatToDo()
iShouldDoThis()
