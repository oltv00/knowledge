/* Создать структуру “Описание файла” содержащую свойства:
 - путь к файлу
 - имя файла
 - максимальный размер файла на диске
 - путь к папке, содержащей этот файл
 - тип файла (скрытый или нет)
 - содержимое файла (можно просто симулировать контент)
 
 Главная задача - это использовать правильные свойства там, где нужно, чтобы не пришлось хранить одни и те же данные в разных местах и т.д. и т.п. */

import Foundation

struct FileDescription {
  var path: NSMutableString
  var name: String {return path.lastPathComponent}
  var folder: String {return path.stringByDeletingLastPathComponent}
  var isHidden: Bool
  
  static let maxFileSize = 1024
  var contentErrors: Int = 0
  var size: Int {return content.count * 4}
  var content: Array<String> {
    didSet {
      if size > FileDescription.maxFileSize {
        self.contentErrors += 1
        content = oldValue
      }
    }
  }
  
  init(path: NSMutableString, isHidden: Bool, content: Array<String>) {
    self.path = path
    self.isHidden = isHidden
    self.content = content
  }
}

let filePath: NSMutableString = "/Users/oltv00/Desktop/SDC-Lesson.swift"
var file = FileDescription.init(path: filePath, isHidden: false, content: [String]())

print("file path = \(file.path)")
print("file name = \(file.name)")
print("file folder = \(file.folder)")
print("is hidden = \(file.isHidden)")

let inputChars = "se123124erJDHFJKSDfghfhH456456FJK#&$*(s@ghjgjhfghj&#($*@"
func randomChar() -> Character {
  let index = Int(arc4random_uniform(UInt32(inputChars.characters.count)))
  for (idx, val) in inputChars.characters.enumerate() {
    if idx == index { return val }
  }
  return randomChar()
}

let contentCount = 300
let charsInContent = 1
for _ in 0..<contentCount {
  var string: String = ""
  for _ in 0..<charsInContent {
    string.append(randomChar())
  }
  file.content.append(string)
}

print("file size = \(file.size)")
//print("file content = \(file.content)")
print("content count = \(file.content.count)")
print("content write errors = \(file.contentErrors)")





