//
//  SubCategoryTableViewController.swift
//  Test-Yandex
//
//  Created by Oleg Tverdokhleb on 08/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit
import CoreData

class SubCategoryTableViewController: CoreDataTableViewController {
  
  // MARK: - Properties
  
  var category: Category!
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // setups
    setupNavigationItem()
    setupFetchedResultsController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Setup
  
  func setupFetchedResultsController() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: kEntityName.subCategory)
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
    // add predicate with current category
    request.predicate = NSPredicate(format: "category == %@", category)
    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
  }
  
  func setupNavigationItem() {
    navigationItem.title = category.title
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier.subCategory, for: indexPath)
    if let subCategory = fetchedResultsController?.object(at: indexPath) as? SubCategory {
      cell.textLabel?.text = subCategory.title
      cell.detailTextLabel?.text = "ID: \(subCategory.id!)"
    }
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
