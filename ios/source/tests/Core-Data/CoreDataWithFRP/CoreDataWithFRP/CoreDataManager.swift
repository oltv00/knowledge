//
//  CoreDataStack.swift
//  tttt
//
//  Created by Oleg Tverdokhleb on 07/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  
  static let shared: CoreDataManager = {
    return CoreDataManager()
  }()
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (store, error) in
      if let error = error as NSError? {
        fatalError("\(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func save() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("\(error), \(error.userInfo)")
      }
    }
  }
  
  
  
}
