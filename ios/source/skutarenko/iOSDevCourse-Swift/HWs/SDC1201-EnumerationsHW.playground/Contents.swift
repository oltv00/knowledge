// SWIFT Марафон. Урок 12: Энумы
// Король, ферзь, слон, ладья, конь, пешка
// King, queen, bishop, rook, knight, pawn

/*
 1. Создать энум с шахматными фигруами (король, ферзь и т.д.). Каждая фигура должна иметь цвет белый либо черный (надеюсь намек понят), а так же букву и цифру для позиции. Создайте пару фигур с расположением на доске, так, чтобы черному королю был мат :) Поместите эти фигуры в массив фигур
 */

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

enum Column: String {
  case A = "A"; case B = "B"; case C = "C"; case D = "D";
  case E = "E"; case F = "F"; case G = "G"; case H = "H"
}

typealias Position = (
  line: Int,
  column: Column
)

typealias Figure = (
  type: Type,
  color: Color,
  position: Position
)

var whiteQueen: Figure = (Type.Queen, Color.White, (5, Column.A))
var whiteKnight: Figure = (Type.Knight, Color.White, (6, Column.D))
var whiteBishop: Figure = (Type.Bishop, Color.White, (5, Column.G))
var whiteKing: Figure = (Type.King, Color.White, (1, Column.B))
var blackKing: Figure = (Type.King, Color.Black, (8, Column.D))

var figures = [whiteQueen, whiteKnight, whiteBishop, whiteKing, blackKing]

/*
 2. Сделайте так, чтобы энумовские значения имели rawValue типа String. Каждому типу фигуры установите соответствующее английское название. Создайте функцию, которая выводит в консоль (текстово, без юникода) название фигуры, цвет и расположение. Используя эту функцию распечатайте все фигуры в массиве.
 */

func printFigure(figure: Figure) -> String {
  let type = figure.type.rawValue
  let color = figure.color.rawValue
  let line = figure.position.line
  let column = figure.position.column.rawValue
  return "Type = \(type), Color = \(color), Position = (\(line),\(column))"
}

func printFigures(figures:[Figure]) {
  print("\n\t\t\tPRINT - ALL - FIGURES")
  for figure in figures { print(printFigure(figure)) }
  print("\t\tEND - PRINT - ALL - FIGURES\n")
}

//printFigures(figures)

/*
 3. Используя красивые юникодовые представления шахматных фигур, выведите в консоли вашу доску. Если клетка не содержит фигуры, то используйте белую или черную клетку. Это должна быть отдельная функция, которая распечатывает доску с фигурами (принимает массив фигур и ничего не возвращает)
 */

/*Название	Король	Ферзь	Ладья	Слон	Конь	Пешка
 Белые	Символ	♔	♕	♖	♗	♘	♙
 Код	U+2654	U+2655	U+2656	U+2657	U+2658	U+2659
 HTML	&#9812;	&#9813;	&#9814;	&#9815;	&#9816;	&#9817;
 Чёрные	Символ	♚	♛	♜	♝	♞	♟
 Код	U+265A	U+265B	U+265C	U+265D	U+265E	U+265F
 HTML	&#9818;	&#9819;	&#9820;	&#9821;	&#9822;	&#9823;*/

// Король, ферзь, слон, ладья, конь, пешка
// King, queen, bishop, rook, knight, pawn

let whiteCell = "\u{25a0}"
let blackCell = "\u{25a1}"

let whiteKingCode = "\u{2654}"
let whiteQueenCode = "\u{2655}"
let whiteRookCode = "\u{2656}"
let whiteBishopCode = "\u{2657}"
let whiteKnightCode = "\u{2658}"
let whitePawnCode = "\u{2659}"

let blackKingCode = "\u{265A}"
let blackQueenCode = "\u{265B}"
let blackRookCode = "\u{265C}"
let blackBishopCode = "\u{265D}"
let blackKnightCode = "\u{265E}"
let blackPawnCode = "\u{265F}"

let lines = [8,7,6,5,4,3,2,1]
let columns = ["A","B","C","D","E","F","G","H"]
let strCol = "  A B C D E F G H"

func printChessBoard(figures:[Figure]) {
  print(strCol)
  for line in 0..<8 {
    var string = "\(lines[line])"
    for column in 0..<8 {
      let position: Position = (lines[line], Column.init(rawValue: columns[column])!)
      if contains(figures, position: position) {
        let figure = findFigure(figures, byPosition: position)!
        string += drawFigure(figure)
      } else {
        string += drawCell(line, column: column)
      }
    }
    string += " \(lines[line])"
    print(string)
  }
  
  print(strCol)
}

// helper functions
func drawFigure(figure: Figure) -> String {
  switch figure {
  case let (type:t, color:c, _) where t == .King && c == .White: return " \(whiteKingCode)"
  case let (type:t, color:c, _) where t == .Queen && c == .White: return " \(whiteQueenCode)"
  case let (type:t, color:c, _) where t == .Rook && c == .White: return " \(whiteRookCode)"
  case let (type:t, color:c, _) where t == .Bishop && c == .White: return " \(whiteBishopCode)"
  case let (type:t, color:c, _) where t == .Knight && c == .White: return " \(whiteKnightCode)"
  case let (type:t, color:c, _) where t == .Pawn && c == .White: return " \(whitePawnCode)"
  case let (type:t, color:c, _) where t == .King && c == .Black: return " \(blackKingCode)"
  case let (type:t, color:c, _) where t == .Queen && c == .Black: return " \(blackQueenCode)"
  case let (type:t, color:c, _) where t == .Rook && c == .Black: return " \(blackRookCode)"
  case let (type:t, color:c, _) where t == .Bishop && c == .Black: return " \(blackBishopCode)"
  case let (type:t, color:c, _) where t == .Knight && c == .Black: return " \(blackKnightCode)"
  case let (type:t, color:c, _) where t == .Pawn && c == .Black: return " \(blackRookCode)"
  default: return "ERROR"
  }
}

func drawCell(line: Int,column: Int) -> String {
  return column % 2 == line % 2 ? " \(whiteCell)" : " \(blackCell)"
}

func contains(figures: [Figure], position: Position) -> Bool {
  var contains = false
  for figure in figures {
    if figure.position == position { contains = true; break }
  }
  return contains
}

func findFigure(figures: [Figure], byPosition position: Position) -> Figure? {
  for figure in figures {
    if figure.position == position { return figure }
  }
  return nil
}

printChessBoard(figures)

/*
 4. Создайте функцию, которая будет принимать шахматную фигуру и тюпл новой позиции. Эта функция должна передвигать фигуру на новую позицию, причем перемещение должно быть легальным: нельзя передвинуть фигуру за пределы поля и нельзя двигать фигуры так, как нельзя их двигать в реальных шахматах (для мегамонстров программирования). Вызовите эту функцию для нескольких фигур и распечатайте поле снова.
 */

func moveFigure(figure: Figure, toPosition position: Position) -> Figure {
  
  if position.line == 0 || position.line > 8 {
    print("Wrong new position")
  
  } else {
   
    var figure = figure
    figure.position = position
    return figure
    
  }
  
  return figure
}

blackKing = moveFigure(blackKing, toPosition: (8, .C))

figures = [whiteQueen, whiteKnight, whiteBishop, whiteKing, blackKing]
printFigures(figures)
printChessBoard(figures)






