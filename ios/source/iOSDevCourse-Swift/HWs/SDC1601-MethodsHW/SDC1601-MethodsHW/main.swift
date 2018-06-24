//
//  main.swift
//  SDC1601-MethodsHW
//
//  Created by Oleg Tverdokhleb on 05/08/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

// consts
let MaxGameSize: UInt32 = 5
let MinGameSize = 5
let BoxesCount = 5
let WallIcon = "\u{2b1b}"
let FloorIcon = "\u{2b1c}"
let PersonIcon = "\u{1f468}"
let BoxIcon = "\u{26bd}"
let GoalIcon = "\u{1f3f3}"

class Room {

  var height: Int
  var width: Int
  var person: Person!
  var goal: Goal!
  var boxes = [Box]()
  
  init(h: Int, w: Int) {
    let wallOffset = 1
    self.height = h + wallOffset
    self.width = w + wallOffset
  }
  
  func draw() {
    drawWall()
    drawFloor()
    drawWall()
  }
  
  func drawWall() {
    var wall = WallIcon
    for _ in 0..<self.width { wall += WallIcon }
    print(wall)
  }
  
  func drawFloor() {
    
    for h in 1..<self.height {
    var out = WallIcon
      
      widthDraw: for w in 1...self.width {
        
        // check out for the presence of person and box
        if self.person != nil {
          
          switch (w, h) {
          case (self.person.x, self.person.y): out += PersonIcon; continue widthDraw
          case (self.goal.x, self.goal.y): out += GoalIcon; continue widthDraw
          default: out += w == self.width ? WallIcon : FloorIcon
          }
          
          for box in boxes {
            if (w, h) == (box.x, box.y) {
              out.removeAtIndex(out.endIndex.predecessor())
              out.insert(Character(BoxIcon), atIndex: out.endIndex)
              continue widthDraw
            }
          }
        }
      }
      
      print(out)
    }
  }
  
  func canMove(x: Int, y: Int) -> Bool {
    if x == 0 || y == 0 { return false }
    if x == self.width { return false }
    if y == self.height { return false }
    return true
  }
  
  func isBoxesHere(boxes: [Box], person: Person) -> Box? {
    let personPosition = (person.x, person.y)
    for box in boxes {
      let boxPosition = (box.x, box.y)
      if personPosition == boxPosition { return box }
    }
    return nil
  }
  
  func isWin(goal: Goal, boxes: [Box]) -> Bool {
    for box in boxes {
      if box.inGoal == false { return false }
    }
    return true
  }
}

class AbstractItem {
  var x: Int
  var y: Int
  
  init(roomSize: Int) {
    self.x = 1 + Int(arc4random_uniform(UInt32(roomSize)))
    self.y = 1 + Int(arc4random_uniform(UInt32(roomSize)))
  }
  
  func move(direction: Direction, room: Room) {
    switch direction {
    case .Up:     if room.canMove(x, y: y - 1) { y -= 1 }
    case .Down:   if room.canMove(x, y: y + 1) { y += 1 }
    case .Left:   if room.canMove(x - 1, y: y) { x -= 1 }
    case .Right:  if room.canMove(x + 1, y: y) { x += 1 }
    }
  }
  
  enum Direction {
    case Up
    case Down
    case Left
    case Right
  }
}

class Person: AbstractItem {}
class Goal: AbstractItem {}

// need fix position of all boxes
class Box: AbstractItem {
  var inGoal: Bool!
  
  init(roomSize: Int, inGoal: Bool) {
    super.init(roomSize: roomSize)
    self.inGoal = inGoal
    if x == 1 { x += 1 } else if (x == roomSize) { x -= 1 }
    if y == 1 { y += 1 } else if (y == roomSize) { y -= 1 }
  }
  
  override func move(direction: Direction, room: Room) {
    super.move(direction, room: room)
    if (x, y) == (room.goal.x, room.goal.y) { inGoal = true }
  }
}

// MARK: - Init objects of game
let roomSize = MinGameSize + Int(arc4random_uniform(MaxGameSize))
let room = Room.init(h: roomSize, w: roomSize)
let person = Person.init(roomSize: roomSize)
let goal = Goal.init(roomSize: roomSize)
room.person = person
room.goal = goal

for _ in 0..<BoxesCount {
  let box = Box(roomSize: roomSize, inGoal: false)
  room.boxes.append(box)
}

// MARK: - Game
func input() -> String? {
  let data = NSFileHandle.fileHandleWithStandardInput().availableData
  let input = String.init(data: data, encoding: NSUTF8StringEncoding)
  return input?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

func game() {
  // uncomment if run game from terminal
  //system("clear")
  room.draw()
  
  var exit = false

  if room.isWin(goal, boxes: room.boxes) {
    print("Congratulation! You are win!")
    exit = true
  }
  
  let inputStr = input()
  if let inputStr = inputStr {
    
    switch inputStr {
    case "u":
      person.move(.Up, room: room)
      if let box = room.isBoxesHere(room.boxes, person: person) { box.move(.Up, room: room) }
      
    case "d":
      person.move(.Down, room: room)
      if let box = room.isBoxesHere(room.boxes, person: person) { box.move(.Down, room: room) }
      
    case "l":
      person.move(.Left, room: room)
      if let box = room.isBoxesHere(room.boxes, person: person) { box.move(.Left, room: room) }
      
    case "r":
      person.move(.Right, room: room)
      if let box = room.isBoxesHere(room.boxes, person: person) { box.move(.Right, room: room) }
      
    case "e": exit = true
    default: print("Wrong input data")
    }
  }
  
  if !exit { game() }
  
}

game()
