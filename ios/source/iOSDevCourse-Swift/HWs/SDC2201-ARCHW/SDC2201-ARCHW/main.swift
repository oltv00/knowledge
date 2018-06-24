let scope = true

/*
 Рассмотрим такую ситуацию: есть семья - папа, мама и дети.
 Папа глава семьи, у него есть Мама, Мама контролирует детей, т.е. иерархия: Папа - Мама - Дети, Дети на одном уровне.
 Дети могут вызывать друг друга и они могут искать пути, как общаться с другими Детьми, например говорить "дай игрушку", спрашивать Маму: "Мама, дай конфетку", общаться с Папой: "Папа, купи игрушку".
 Вся эта иерархия лежит в объекте класса Семья, у которого есть методы, например распечатать всю Семью, т.е. метод вернёт массив всех членов Семьи.
 У Папы есть 3 кложера (closures) - 1. когда он обращается к Семье - распечатать всю Семью, 2. распечатать Маму, 3. распечатать всех Детей.
 Создать всю иерархию со связями. При выходе из зоны видимости все объекты должны быть уничтожены. Используем Command-Line Tool.
 */

class Family {
  var dad: Dad
  var mom: Mom
  var kids: [Kid]
  
  init(dad: Dad, mom: Mom, kids: [Kid]) {
    self.dad = dad
    self.mom = mom
    self.kids = kids
  }
  
  func printFamily() {
    print("Dad is here = \(dad)")
    print("Mom is here = \(mom)")
    print("Kids is here")
    for kid in kids { print(kid) }
  }
  
  func printWife() {
    print("Wife is here = \(mom)")
  }
  
  func printKids() {
    print("Kids is here")
    for kid in kids { print(kid) }
  }
  
  deinit {
    print("\(self) is deallocated")
  }
}

class Dad {
  var wife: Mom!
  weak var family: Family!
  
  lazy var printFamily: () -> () = { [unowned self] in
    self.family.printFamily()
  }
  
  lazy var printWife: () -> () = { [unowned self] in
    self.family.printWife()
  }
  
  lazy var printKids: () -> () = { [unowned self] in
    self.family.printKids()
  }
  
  func buyToy() { print("Dad buy a toy") }
  
  deinit { print("\(self) is deallocated") }
}

class Mom {
  weak var husband: Dad!
  var kids = [Kid]()
  
  func giveCandy() { print("Mom give a candy") }
  
  deinit { print("\(self) is deallocated") }
}

class Kid {
  unowned var dad: Dad
  unowned var mom: Mom
  weak var otherKid: Kid!
  
  init(dad: Dad, mom: Mom) {
    self.dad = dad
    self.mom = mom
  }
  
  func giveToy() { print("Kid give a toy") }
  
  deinit { print("\(self) is deallocated") }
}

if scope {
  let dad = Dad()
  let mom = Mom()
  var kids = [Kid]()
  for _ in 0..<2 { kids.append(Kid(dad: dad, mom: mom)) }
  
  dad.wife = mom
  mom.kids = kids
  let kid1 = kids[0]
  let kid2 = kids[1]
  
  kid1.otherKid = kid2
  kid1.otherKid.giveToy()
  
  kid1.dad.buyToy()
  kid1.mom.giveCandy()
  
  
  
  
  let family = Family(dad: dad, mom: mom, kids: kids)
  dad.family = family
  dad.printFamily()
  dad.printWife()
  dad.printKids()
  
  print("Exit scope")
}

print("End")