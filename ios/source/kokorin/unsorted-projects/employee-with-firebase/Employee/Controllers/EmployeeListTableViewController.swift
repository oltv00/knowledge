//
//  EmployeeListTableViewController.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 28/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class EmployeeListTableViewController: UITableViewController {
  
  // MARK: - Properties
  let EmployeeCellIdentifier = "ListCell"
  var employees = [Employee]()
  
  // MARK: - View life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getEmployees()
    activityIndicator()
    setupRefreshControl()
  }
  
  func setupRefreshControl() {
    let refresh = UIRefreshControl(frame: view.bounds)
    refresh.addTarget(self, action: #selector(actionTableRefresh(_:)), for: .valueChanged)
    tableView.refreshControl = refresh
  }
  
  // MARK: - Helper funcs
  
  func configureCell(_ cell: UITableViewCell, isDev: Bool) {
    if isDev {
      cell.accessoryType = .checkmark
      cell.textLabel?.textColor = UIColor.black
      cell.detailTextLabel?.textColor = UIColor.black
    } else {
      cell.accessoryType = .none
      cell.textLabel?.textColor = UIColor.gray
      cell.detailTextLabel?.textColor = UIColor.gray
    }
  }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
  }
  
  
  // MARK: - Action
  
  func actionTableRefresh(_ sender: UIRefreshControl) {
    getEmployees()
    activityIndicator()
  }
  
  // MARK: - Firebase API
  
  func getEmployees() {
    FirebaseAPIManager.sharedManager.getEmployeeProfiles { (employees: [Employee]) in
      if employees.isEmpty {
        self.showAlert(title: "No employees", message: "Just create someone")
      } else {
        self.employees.removeAll()
        self.employees.append(contentsOf: employees)
        self.tableView.reloadData()
      }
      self.activityIndicator()
      self.tableView.refreshControl?.endRefreshing()
    }
  }
  
  func activityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = !UIApplication.shared.isNetworkActivityIndicatorVisible
  }
  
  // MARK: - Navigation
  
  @IBAction func unwindToEmployeeList(_ sender: UIStoryboardSegue) {
    
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCellIdentifier, for: indexPath)
    let employee = employees[indexPath.row]
    configureCell(cell, isDev: employee.isDeveloper)
    cell.textLabel?.text = employee.name
    cell.detailTextLabel?.text = stringOfDobFrom(employee.dob)
    cell.imageView?.image = photoImageFrom(employee.photo)
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    switch editingStyle {
    case .delete:
      
      let employee = employees[indexPath.row]
      FirebaseAPIManager.sharedManager.removeValue(employee.uid) { (error) in
        self.showAlert(title: "Error", message: "Cannot remove the user")
      }
      employees.remove(at: indexPath.row)
      tableView.reloadData()
      
    case .insert: break
    case .none: break
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let employee = employees[indexPath.row]
    let toggle = !employee.isDeveloper
    employee.isDeveloper = toggle
    employees[indexPath.row] = employee
    self.tableView.reloadData()
    
    FirebaseAPIManager.sharedManager.updateValue(uid: employee.uid, row: "isDeveloper", value: toggle)
  }
}
