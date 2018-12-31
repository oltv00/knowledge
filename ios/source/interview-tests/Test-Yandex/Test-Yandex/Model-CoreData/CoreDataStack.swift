//
//  CoreDataHelper.swift
//  Test-Yandex
//
//  Created by Oleg Tverdokhleb on 31/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  
  static let shared: CoreDataStack = {
    return CoreDataStack()
  }()
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CoreData")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func deleteAllObjects() {
    // initialize new background context
    let backgroundContext = persistentContainer.newBackgroundContext()
    
    // OLTVObject is abstract class and parent of all entities in CoreData
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OLTVObject")
    let batch = NSBatchDeleteRequest(fetchRequest: fetch)
    
    do {
      try backgroundContext.execute(batch)
      try backgroundContext.save()
    } catch let error as NSError {
      fatalError("Unresolved error \(error), \(error.userInfo)")
    }
  }
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
}
