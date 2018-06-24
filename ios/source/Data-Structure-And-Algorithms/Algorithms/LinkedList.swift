//
//  LinkedList.swift
//  Sorting
//
//  Created by Oleg Tverdokhleb on 22/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

class LinkedListNode {
  public var value: Any
  public var next: LinkedListNode?
  
  init(_ value: Any) {
    self.value = value
  }
}

class LinkedList {
  
  private var _head: LinkedListNode?
  private var _tail: LinkedListNode?
  
  var count: Int = 0
  var isReadOnly: Bool?
  
  func add<T>(item: T) {
    
    let node = LinkedListNode(item)
    
    if _head == nil {
      _head = node
      _tail = node
    } else {
      _tail?.next = node
      _tail = node
    }
    
    count += 1
  }
  
  func clear() {}
  func contains<T>(item: T) -> Bool { return true }
  func copyTo<T>(array: [T], index: Int) {}
  
  func remove<T>(item: T) -> Bool {
    
    // 1: Пустой список: ничего не делать.
    // 2: Один элемент: установить Previous = null.
    // 3: Несколько элементов:
    //    a: Удаляемый элемент первый.
    //    b: Удаляемый элемент в середине или конце.
    
    var previous: LinkedListNode?
    var current = _head
    
    // обходим весь список
    while (current != nil) {
      
      // нашли текущее значение
      if current!.value == item {
        
        // item в середине или в конце
        if previous != nil {
          
          previous?.next = current?.next
          
          // если в конце, то меняем _tail
          if current?.next == nil {
            _tail = previous
          }
          
        } else {
          
          // случай 2 или 3а
          
          _head = _head?.next
          
          // список пуст?
          if _head == nil {
            _tail = nil
          }
        }
        
        count -= 1
        return true
        
      }
      
      previous = current
      current = current?.next
    }
    
    return false
  }
  
  func printList() {
    var node = _head
    while node != nil {
      print(node!.value)
      node = node?.next
    }
  }
  
}

func main_LinkedList() {
  let list = LinkedList()
  list.add(item: 1)
  list.add(item: 2)
  list.add(item: 3)
  
  list.printList()
  print("list count = \(list.count)")
  
  if list.remove(item: 2) {
    print("Item remove success")
  } else {
    print("Item remove error")
  }
  
  list.printList()
  print("list count = \(list.count)")
  
}













