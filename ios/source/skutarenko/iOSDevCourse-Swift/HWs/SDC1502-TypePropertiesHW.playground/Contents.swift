/* Создайте энум, который будет представлять некую цветовую гамму. Этот энум должен быть типа Int и как raw значение должен иметь соответствующее 3 байтное представление цвета. Добавьте в этот энум 3 свойства типа: количество цветов в гамме, начальный цвет и конечный цвет.
*/

enum Color: Int {
  case Red = 0xFF0000
  case Green = 0x00FF00
  case Blue = 0x0000FF
  
  static let count: Int = 3
  static let firstColor = Color.Red
  static let lastColor = Color.Blue
}

Color.Red.rawValue
Color.Green.rawValue
Color.Blue.rawValue

