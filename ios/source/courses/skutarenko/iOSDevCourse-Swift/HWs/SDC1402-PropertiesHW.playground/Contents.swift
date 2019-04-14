/* Создать структуру «Отрезок», содержащую две внутренние структуры «Точки». Структуру «Точка» создать самостоятельно, несмотря на уже имеющуюся в Swift’е. Таким образом, структура «Отрезок» содержит две структуры «Точки» — точки A и B (stored properties). Добавить два computed properties: « середина отрезка» и «длина» (считать математическими функциями) */

/* При изменении середины отрезка должно меняться положение точек A и B. При изменении длины, меняется положение точки B */

import Foundation
struct Segment {

  struct Point {
    var x : Double
    var y : Double
  }
  
  var pointA : Point
  var pointB : Point
  
  var midPoint : Point {
    get {
      let x = (pointA.x + pointB.x) / 2
      let y = (pointA.y + pointB.y) / 2
      return Point.init(x: x, y: y)
    }
    
    set {
      let diffX = newValue.x - midPoint.x
      let diffY = newValue.y - midPoint.y
      
      pointA.x += diffX
      pointB.x += diffX
      
      pointA.y += diffY
      pointB.y += diffY
    }
  }
  
  var length : Double {
    get {
      let x = pow((pointB.x - pointA.x), 2)
      let y = pow((pointB.y - pointA.y), 2)
      return sqrt(x + y)
    }
    
    set {
      let x = pointA.x + (pointB.x - pointA.x) * newValue / length
      let y = pointA.y + (pointB.y - pointA.y) * newValue / length
      pointB = Point(x: x, y: y)
    }
  }
}

let pointA = Segment.Point.init(x: 0, y: 0)
let pointB = Segment.Point.init(x: 0, y: 10)
var segment = Segment(pointA: pointA, pointB: pointB)

print("Segment = \(segment)")
print("Mid Point = \(segment.midPoint)")
print("Lenght = \(segment.length)")

segment.midPoint = Segment.Point.init(x: 0, y: 10)
segment.length = 5.0

print("Segment = \(segment)")
print("Mid Point = \(segment.midPoint)")
print("Lenght = \(segment.length)")





