//
//  ViewController.swift
//  tttt
//
//  Created by Oleg Tverdokhleb on 07/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: CoreDataTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // register tableview cell
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    // add
    let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    navigationItem.setRightBarButton(addItem, animated: true)
    
    setupFRP()
  }
  
  func setupFRP() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Name")
    request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
  }
  
  func add() {
    
    let alert = UIAlertController(title: "Enter name", message: "", preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default) { (action) in
      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else { return }
      
      let context = CoreDataManager.shared.persistentContainer.viewContext
      let name = Name(context: context)
      name.text = nameToSave
      CoreDataManager.shared.save()
      
    }
    
    alert.addTextField()
    alert.addAction(ok)
    
    present(alert, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    let name = self.fetchedResultsController?.object(at: indexPath) as? Name
    cell?.textLabel?.text = name?.text
    return cell!
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    switch editingStyle {
    case .delete:
      
      let context = CoreDataManager.shared.persistentContainer.viewContext
      guard let obj = self.fetchedResultsController?.object(at: indexPath) as? Name else { return }
      context.delete(obj)
      CoreDataManager.shared.save()
      
    case .insert: break
    case .none: break
    }
    
  }
  
}
