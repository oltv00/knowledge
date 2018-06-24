//
//  ViewController.swift
//  test-yandex
//
//  Created by Oleg Tverdokhleb on 29/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: CoreDataTableViewController {
  
  // MARK: - Properties
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // check for first launch application
    if UserDefaults.standard.value(forKey: kUserDefaults.isFirstLaunch) == nil {
      UserDefaults.standard.set(false, forKey: kUserDefaults.isFirstLaunch)
      fetchDataFromServer()
    }
    
    // setups
    setupDownloadDataButton()
    setupNavigationItem()
    setupFetchedResultsController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - API
  
  func fetchDataFromServer() {
    ServerManagerAPI.shared.categoriesList { [unowned self] (requestState) in
      DispatchQueue.main.async {
        switch requestState {
        case .responseSuccess:
          UIAlertController.showAlertInVC(vc: self, title: kAlert.successTitle, message: kAlert.successMessage)
          
        case .noInternetConnection:
          UIAlertController.showAlertInVC(vc: self, title: kAlert.errorTitle, message: kAlert.noInternetMessage)
          
        case .serverError:
          UIAlertController.showAlertInVC(vc: self, title: kAlert.errorTitle, message: kAlert.serverErrorMessage)
        }
        
        self.setupFetchedResultsController()
      }
    }
  }
  
  // MARK: - Setup
  
  // setup fetched result controller
  func setupFetchedResultsController() {
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: kEntityName.category)
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
  }
  
  func setupNavigationItem() {
    // vc title setup
    navigationItem.title = "Товары и услуги"
    
    // back bar button item title setup
    let back = UIBarButtonItem()
    back.title = ""
    navigationItem.backBarButtonItem = back
  }
  
  func setupDownloadDataButton() {
    let download = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(actionDownloadData(_:)))
    navigationItem.setRightBarButton(download, animated: true)
  }
  
  // MARK: - Action
  
  func actionDownloadData(_ sender: UIBarButtonItem) {
    CoreDataStack.shared.deleteAllObjects()
    fetchDataFromServer()
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier.category, for: indexPath)
    if let category = self.fetchedResultsController?.object(at: indexPath) as? Category {
      cell.textLabel?.text = category.title
    }
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let category = self.fetchedResultsController?.object(at: indexPath) as? Category
    let vc = storyboard?.instantiateViewController(withIdentifier: kController.subCategory) as! SubCategoryTableViewController
    vc.category = category
    navigationController?.pushViewController(vc, animated: true)
  }
}
