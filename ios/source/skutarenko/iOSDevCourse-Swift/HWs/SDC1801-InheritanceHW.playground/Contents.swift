/*
 1. У нас есть базовый клас "Артист" и у него есть имя и фамилия. И есть метод "Выступление". У каждого артиста должно быть свое выступление: танцор танцует, певец поет и тд. А для художника, что бы вы не пытались ставить, пусть он ставит что-то свое (пусть меняет имя на свое артистическое). Когда вызываем метод "выступление" показать в консоле имя и фамилию артиста и собственно само выступление.

 Полиморфизм используем для артистов. Положить их всех в массив, пройтись по нему и вызвать их метод "выступление" 
 */

class Actor {
  var firstName: String = ""
  var lastName: String = ""
  var fullName: String {
    return firstName + " " + lastName
  }
  
  func play() -> String {
    return self.fullName
  }
}

class Dancer: Actor {
  override func play() -> String {
    return super.play() + " dances"
  }
}

class Singer: Actor {
  override func play() -> String {
    return super.play() + " sings"
  }
}

class Artist: Actor {
  override var firstName: String {
    didSet { super.firstName = "VERY ACTISTICAL NAME" }
  }
  
  override func play() -> String {
    return super.play() + " draws"
  }
}

let dancer = Dancer()
dancer.firstName = "dancer"
dancer.lastName = "super dancer"

let singer = Singer()
singer.firstName = "singer"
singer.lastName = "super singer"

let artist = Artist()
artist.firstName = "artist"
artist.lastName = "super artist"

let actors = [dancer, singer, artist]
for actor in actors {
  print(actor.play())
}
