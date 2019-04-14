/* Шахматная доска (Легкий уровень)
1. Создайте тип шахматная доска.
2. Добавьте сабскрипт, который выдает цвет клетки по координате клетки (буква и цифра).
3. Если юзер ошибся координатами - выдавайте нил */

struct ChessBoard {
  subscript(row: Int, column: String) -> String? {
    
    let error = "Incorrect enter data"
    if row <= 0 || row > 8 { return error }
    
    let columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let column = columns.indexOf(column)
    if let column = column {
      return row % 2 == column % 2 ? "White" : "Black"
    } else {
      return error
    }
  }
}

let chessBoard = ChessBoard()
chessBoard[1, "e"]
chessBoard[8, "e"]

chessBoard[0, "e"]
chessBoard[15, "e"]

chessBoard[5, "j"]
