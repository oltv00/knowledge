/*
 Есть 5 классов: люди, крокодилы, обезьяны, собаки, жирафы. (в этом задании вы будете создавать не дочерние классы, а родительские и ваша задача создать родительский таким образом, что бы группировать эти 5).
- Создайте по пару объектов каждого класса.
- Посчитайте пресмыкающихся (создайте массив, поместите туда пресмыкающихся и скажите сколько в нем объектов)
- Сколько четвероногих?
- Сколько здесь животных?
- Сколько живых существ? 
 */

import Foundation

class Creature {}

class Animal: Creature {}
class Quadruped: Animal {}

class Human: Creature {}
class Crocodile: Quadruped {}
class Monkey: Animal {}
class Dog: Quadruped {}
class Giraffe: Quadruped {}

var counts = (quadruped: 0, animal: 0, creature: 0)
let creatures = [Human(), Crocodile(), Monkey(), Dog(), Giraffe()]
var zoo = [Creature]()

for _ in 0..<100 {
  let idx = Int(arc4random_uniform(UInt32(creatures.count)))
  let creature = creatures[idx]
  zoo.append(creature)
}

for creautre in zoo {
  counts.creature += 1
  if creautre is Quadruped { counts.quadruped += 1 }
  if creautre is Animal { counts.animal += 1 }
}

print("Quadrupeds = \(counts.quadruped)")
print("Animals = \(counts.animal)")
print("Creauters = \(counts.creature)")
