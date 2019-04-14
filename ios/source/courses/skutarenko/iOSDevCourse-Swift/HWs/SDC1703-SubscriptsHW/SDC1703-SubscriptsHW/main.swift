//
//  main.swift
//  SDC1703-SubscriptsHW
//
//  Created by Oleg Tverdokhleb on 15/08/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

/* Морской бой (Тяжелый уровень)
 
 1. Создайте тип корабль, который будет представлять собой прямоугольник. В нем может быть внутренняя одномерная система координат (попахивает сабскриптом). Корабль должен принимать выстрелы по локальным координатам и вычислять когда он убит
 
 2. Создайте двумерное поле, на котором будут располагаться корабли врага. Стреляйте по полю и подбейте вражеский четырех трубник :)
 
 3. Сделайте для приличия пару выстрелов мимо, красивенько все выводите на экран :) */

struct Point {
  var x: Int
  var y: Int
  
  func isEqual(point: Point) -> Bool {
    return x == point.x && y == point.y
  }
}

class Ship {
  
  // Deck class
  class Deck {
    enum DeckState { case Normal, Wounded }
    
    var state: DeckState
    var point: Point
    
    init(point: Point) {
      self.state = .Normal
      self.point = point
    }
  }
  
  // Ship class
  enum ShipState { case Alive, Killed }
  enum Direction { case Up, Down, Left, Right }
  
  let origin: Point
  var state: ShipState
  let direction: Direction
  let length: Int
  var decks = [Deck]()
  
  init(origin: Point, length: Int, direction: Direction) {
    self.origin = origin
    self.direction = direction
    self.length = length
    self.state = .Alive
    self.decks.append(Deck(point: origin))
    
    
    for idx in 1..<length {
      // init current deck with point of previous deck
      let prevDeck = self.decks[idx - 1]
      let deck = Deck(point: prevDeck.point)
      
      switch direction {
      case .Up:     deck.point.x += 1
      case .Down:   deck.point.x -= 1
      case .Left:   deck.point.y += 1
      case .Right:  deck.point.y -= 1
      }
      
      self.decks.append(deck)
    }
  }
  
  func isAlive() -> Bool {
    for deck in decks {
      if deck.state == .Normal {
        return true
      }
    }
    return false
  }
}

class Field {
  enum CellView: String {
    case Empty = "⬜", Miss = "⭕️", Deck = "⚫️", WoundDeck = "🔥", Killed = "💀"
  }
  
  let size: Int
  var ships = [Ship]()
  var grid = [[CellView]]()
  
  init(size: Int) {
    self.size = size
    self.clear()
  }
  
  func clear() {
    let row = Array(count: size, repeatedValue: CellView.Empty)
    self.grid = Array(count: size, repeatedValue: row)
  }
  
  func draw() {
    print()
    for x in 0..<size {
      for y in 0..<size {
        let cell = self.grid[x][y].rawValue
        print(cell, terminator: "")
      }
      print()
    }
  }
  
  func isValidShip(ship: Ship) -> Bool {
    var valid = true
    for deck in ship.decks {
      if !isPointInField(deck.point) {
        print("Ship with deck point = [\(deck.point.x),\(deck.point.y)] out of field!")
        valid = false
      }
    }
    if !valid { print("Please FIX your ship, and try to add again\n") }
    return valid
  }
  
  func appendShip(ship: Ship) {
    if isValidShip(ship) {
      self.ships.append(ship)
      for deck in ship.decks {
        let p = deck.point
        self.grid[p.x][p.y] = CellView.Deck
      }
    }
  }
  
  func appendShips(ships: Ship...) {
    for ship in ships {
      self.appendShip(ship)
    }
  }
  
  func shot(point: Point) {
    if isPointInField(point) {
      loop: for (idx, ship) in ships.enumerate() {
        for deck in ship.decks {
          
          if deck.point.isEqual(point) {
            
            switch deck.state {
            case .Normal:
              deck.state = .Wounded
              self.grid[point.x][point.y] = .WoundDeck
            case .Wounded:
              print("The deck [\(point.x):\(point.y)] already wounded! Try another point!")
            }
            
            if !ship.isAlive() {
              for deck in ship.decks {
                let p = deck.point
                self.grid[p.x][p.y] = .Killed
              }
              ship.state = .Killed
              self.ships.removeAtIndex(idx)
            }
            
            break loop
            
          } else if ships.count - 1 == idx {
            self.grid[point.x][point.y] = .Miss
            break loop
          }
        }
      }
    } else {
      print("Shot point = [\(point.x),\(point.y)] out of field!")
    }
  }
  
  func isPointInField(point: Point) -> Bool {
    return 0..<size ~= point.x && 0..<size ~= point.y
  }
}

let field = Field(size: 8)
let sh1 = Ship(origin: Point(x: 3, y: 2), length: 3, direction: .Up)
let sh2 = Ship(origin: Point(x: 1, y: 2), length: 3, direction: .Right)
let sh3 = Ship(origin: Point(x: 1, y: 4), length: 3, direction: .Left)
let sh4 = Ship(origin: Point(x: 6, y: 5), length: 3, direction: .Down)
let sh5 = Ship(origin: Point(x: 6, y: 0), length: 5, direction: .Up)
field.appendShips(sh1, sh2, sh3, sh4, sh5)
field.draw()

field.shot(Point(x: 3, y: 2))
field.draw()

field.shot(Point(x: 4, y: 2))
field.draw()

field.shot(Point(x: 5, y: 2))
field.draw()

field.shot(Point(x: 6, y: 2))
field.draw()

field.shot(Point(x: 6, y: 8))




































