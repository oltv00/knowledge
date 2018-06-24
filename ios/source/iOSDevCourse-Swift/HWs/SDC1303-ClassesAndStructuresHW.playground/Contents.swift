class Figure {
  enum Type: String {
    case King   = "King"
    case Queen  = "Queen"
    case Bishop = "Bishop"
    case Rook   = "Rook"
    case Knight = "Knight"
    case Pawn   = "Pawn"
  }
  
  enum Color: String {
    case White = "White"
    case Black = "Black"
  }
  
  var type: Type
  var color: Color
  var position: Position
  
  init(t: Type, c: Color, p: Position) {
    type = t
    color = c
    position = p
  }
}

struct Position {
  enum Column: String {
    case A = "A"; case B = "B"; case C = "C"; case D = "D";
    case E = "E"; case F = "F"; case G = "G"; case H = "H"
  }
  
  var row: Int
  var column: Column
}

var whiteQueen = Figure(t: .Queen, c: .White, p: Position(row: 5, column: .A))
var whiteKnight = Figure(t: .Knight, c: .White, p: Position(row: 6, column: .D))
var whiteBishop = Figure(t: .Bishop, c: .White, p: Position(row: 5, column: .G))
var whiteKing = Figure(t: .King, c: .White, p: Position(row: 1, column: .B))
var blackKing = Figure(t: .King, c: .Black, p: Position(row: 8, column: .D))

var figures = [whiteQueen, whiteKnight, whiteBishop, whiteKing, blackKing]

func printFigure(figure: Figure) -> String {
  let type = figure.type.rawValue
  let color = figure.color.rawValue
  let row = figure.position.row
  let column = figure.position.column.rawValue
  return "Type = \(type), Color = \(color), Position = (\(row),\(column))"
}

func printFigures(figures: [Figure]) {
  print("\n\t\t\tPRINT - ALL - FIGURES")
  for figure in figures { print(printFigure(figure)) }
  print("\t\tEND - PRINT - ALL - FIGURES\n")
}

printFigures(figures)
























