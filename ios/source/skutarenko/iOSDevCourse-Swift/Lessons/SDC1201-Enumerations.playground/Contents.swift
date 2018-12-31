enum Direction : String {
  case Left = "Left side"
  case Right = "Right side"
}

enum Action {
  case Walk(meters: Int)
  case Run(meters: Int, speed: Double)
  case Stop
  case Turn(direction: Direction)
  
  enum Fight : String {
    case LeftHand = "abc"
    case RightHand
  }
}

var action = Action.Run(meters: 20, speed: 15.0)
//action = .Stop
//action = .Walk(meters: 250)

action = .Turn(direction: .Left)
action = .Turn(direction: .Right)
action = .Turn(direction: Direction(rawValue: "Left side")!)

var direction = Direction(rawValue: "Right side")!
action = .Turn(direction: direction)

switch action {
case .Stop: print("Stop")
  
case .Walk(let some) where some < 100:
  print("Walk short \(some) meters")
case .Walk(let some):
  print("Walk long \(some) meters")
case .Run(let m, let s):
  print("Run \(m) meters with \(s) speed")
  
case .Turn(let dir) where dir == .Left:
  print("Turn Left")
case .Turn(let dir) where dir == .Right:
  print("Turn Right")
  
default:break
}

print(Direction.Left)
print(Direction.Left.rawValue)
