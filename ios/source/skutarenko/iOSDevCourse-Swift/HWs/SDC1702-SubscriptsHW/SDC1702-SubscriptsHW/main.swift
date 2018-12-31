//
//  main.swift
//  SDC1702-SubscriptsHW
//
//  Created by Oleg Tverdokhleb on 14/08/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

/* Крестики нолики (Средний уровень)
 
 1. Создать тип, представляющий собой поле для игры в крестики нолики
 На каждой клетке может быть только одно из значений: Пусто, Крестик, Нолик
 Добавьте возможность красиво распечатывать поле
 
 2. Добавьте сабскрипт, который устанавливает значение клетки по ряду и столбцу, причем вы должны следить за тем, чтобы программа не падала если будет введен не существующий ряд или столбец.
 
 3. Также следите за тем, чтобы нельзя было устанавливать крестик либо нолик туда, где они уже что-то есть. Добавьте метод очистки поля.
 
 4. Если хотите, добавьте алгоритм, который вычислит победителя */

import Foundation

class Field {
  let size: Int
  var cells: [String: Cell]
  
  init(size: Int) {
    self.size = size
    self.cells = [String: Cell]()
    
    for column in 1...size {
      for row in 1...size {
        let cell = Cell(point: Cell.Point(x: column, y: row))
        self.cells[keyForCell(column, row: row)] = cell
      }
    }
  }
  
  subscript(column: Int, row: Int) -> Cell.Value? {
    get { return cells[keyForCell(column, row: row)]?.value }
    set {
      if let cell = cells[keyForCell(column, row: row)] {
        if cell.value == Cell.Value.Clear {
          cell.value = newValue!
        } else {
          print("[\(column),\(row)] already have value = \(cell.value.rawValue)")
        }
      } else {
        print("[\(column),\(row)] - wrong column or row!")
      }
    }
  }
  
  func keyForCell(column: Int, row: Int) -> String {
    return String(column) + String(row)
  }
  
  func draw() {
    for column in 1...size {
      var out: String = ""
      
      for row in 1...size {
        out += (cells[keyForCell(column, row: row)]?.value.rawValue)!
      }
      print(out)
    }
    print("")
  }
  
  func clear() {
    for cell in cells.values { cell.value = Cell.Value.Clear }
  }
  
  
}

class Cell {
  let point: Point
  var value: Value
  
  init(point: Point) {
    self.point = point
    self.value = .Clear
  }
  
  enum Value: String {
    case Clear = "\u{2b1c}"
    case X = "\u{274c}"
    case O = "\u{2b55}"
  }
  
  struct Point {
    var x: Int
    var y: Int
  }
}

//MARK: - Game

func newField() -> Field {
  if let str = input() {
    if let size = Int(str) {
      return Field.init(size: size)
    } else {
      print("You are enter incorrect size, try again!")
      return newField()
    }
  } else {
    print("You need to enter something!")
    return newField()
  }
}

func input() -> String? {
  let data = NSFileHandle.fileHandleWithStandardInput().availableData
  let input = String.init(data: data, encoding: NSUTF8StringEncoding)
  return input?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

func newGame() -> Field {
  print("Enter size of game field, 3, 4, 5, or more...")
  return newField()
}

func gameInProcess(field: Field) {
  field.draw()
  
  print("Enter numbers separated by commas")
  if let command = input() {
    var x = 0; var y = 0
    let command = command.componentsSeparatedByString(",")
    if command.count < 2 {
      print("Incorrect enter, try again please!")
    } else {
      x = Int(command[0])!; y = Int(command[1])!
      print("Enter X or O")
      if let value = input() {
        switch value.lowercaseString {
        case "x": field[x, y] = Cell.Value.X
        case "o": field[x, y] = Cell.Value.O
        default: print("Incorrect enter, try again please!")
        }
      }
    }
  }
  
  gameInProcess(field)
}

let field = newGame()
gameInProcess(field)

