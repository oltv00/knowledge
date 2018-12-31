//
//  ViewController.swift
//  coredata-test
//
//  Created by Oleg Tverdokhleb on 09/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  // MARK: - Properties
  
  let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  weak var tableView: UITableView!
  var models = [Model]()
  
  // MARK: - View Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupTableView()
    fetchDataFromDatabase()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Setup
  
  func setupTableView() {
    let tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
    self.tableView = tableView
    
    let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAdd(_:)))
    let deleteItem = (UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(actionDeleteAll(_:))))
    let reloadItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(actionReload(_:)))
    
    navigationItem.setRightBarButtonItems([reloadItem, addItem], animated: true)
    navigationItem.setLeftBarButton(deleteItem, animated: true)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }

  // MARK: - Action
  
  func actionDeleteAll(_ sender: UIBarButtonItem) {
    deleteAllObjects()
  }
  
  func actionAdd(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "How many?", message: "", preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default) { [unowned self] (action) in
      if let textField = alert.textFields?.first as UITextField? {
        self.generateObjects(Int(textField.text!)!)
      }
    }
    
    alert.addTextField()
    alert.addAction(ok)
    present(alert, animated: true)
  }
  
  func actionReload(_ sender: UIBarButtonItem) {
    
    let count = models.count
    deleteAllObjects()
    generateObjects(count)
    
  }
  
  // MARK: - Private
  
  func fetchDataFromDatabase() {
    do {
      models = try moc.fetch(Model.fetchRequest())
      self.tableView.reloadData()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  func generateObjects(_ count: Int) {
    
    for i in 0..<count {
      
      let model = Model(context: moc)
      model.name = String(i)
    }
    
    do {
      try moc.save()
      self.fetchDataFromDatabase()
    } catch {
      fatalError(error.localizedDescription)
    }
    
  }
  
  func deleteAllObjects() {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Model")
    let batch = NSBatchDeleteRequest(fetchRequest: fetch)
    do {
      try moc.execute(batch)
      self.fetchDataFromDatabase()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Models in Database: \(models.count)"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let model = models[indexPath.row]
    cell.textLabel?.text = model.name
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  
}
