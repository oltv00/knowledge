/*1. Создать тюпл с тремя параметрами:
 - максимальное количество отжиманий
 - максимальное количество подтягиваний
 - максимальное количество приседаний
 Заполните его своими достижениями :)
 Распечатайте его через println()
*/

let aTuple = (name:"Oleg", pushUps:30, squats:50, sitUps:20, pullUps:10)

/*
 2. Также сделайте три отдельных вывода в консоль для каждого параметра
 При том одни значения доставайте по индексу, а другие по параметру
 */

print("Workout results for \(aTuple.0)")
print("PushUps: \(aTuple.pushUps)")
print("Squats: \(aTuple.squats)")
print("SitUps: \(aTuple.sitUps)")
print("PullUps: \(aTuple.4)")

/*
 3. Создайте такой же тюпл для другого человека (супруги или друга)
 с такими же параметрами, но с другими значениями
 Используйте промежуточную переменную чтобы поменять соответствующие значения
 первого тюпла на значения второго
 */

let bTuple = (name:"Oleg's Friend", pushUps:20, squats:100, sitUps:25, pullUps:5)

var aTupleVar = aTuple
var bTupleVar = bTuple

print("\nBefore exchange of tuples")
print("aTupleVar = \(aTupleVar)")
print("bTupleVar = \(bTupleVar)")

var stringTemp : String
var intTemp : Int

stringTemp = aTupleVar.name
aTupleVar.name = bTupleVar.name
bTupleVar.name = stringTemp

intTemp = aTupleVar.pushUps
aTupleVar.pushUps = bTupleVar.pushUps
bTupleVar.pushUps = intTemp

intTemp = aTupleVar.squats
aTupleVar.squats = bTupleVar.squats
bTupleVar.squats = intTemp

intTemp = aTupleVar.sitUps
aTupleVar.sitUps = bTupleVar.sitUps
bTupleVar.sitUps = intTemp

intTemp = aTupleVar.pullUps
aTupleVar.pullUps = bTupleVar.pullUps
bTupleVar.pullUps = intTemp

print("\nAfter exchange of tuples")
print("aTupleVar = \(aTupleVar)")
print("bTupleVar = \(bTupleVar)")

/*
 4. Создайте третий тюпл с теми же параметрами, но значения это разница
 между соответствующими значениями первого и второго тюплов
 Результат выведите в консоль
 */

var cTuple : (name:String, pushUps:Int, squats:Int, pullUps:Int)
cTuple.name = "Diff tuple"
cTuple.pushUps = aTuple.pushUps - bTuple.pushUps
cTuple.squats = aTuple.squats - bTuple.squats
cTuple.pullUps = aTuple.pullUps - bTuple.pullUps
print(cTuple)







