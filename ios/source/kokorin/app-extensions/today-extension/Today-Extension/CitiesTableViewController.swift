//
//  CitiesTableViewController.swift
//  Today-Extension
//
//  Created by Oleg Tverdokhleb on 22/09/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  let city = ["Myrmansk, Russia", "Moscow, Russia", "Odessa, Ukraine", "Seattle, U.S."]
  var selectedCity = ""
  
  var defaults = UserDefaults(suiteName: "group.com.oltv00.Today-Extension")
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return city.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    cell.textLabel?.text = city[indexPath.row]
    cell.accessoryType = city[indexPath.row] == selectedCity ? .checkmark : .none
    
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
    selectedCity = city[indexPath.row]
    //defaults?.setValue(selectedCity, forKeyPath: "city")
    defaults?.set(selectedCity, forKey: "city")
    tableView.reloadData()
  }
}
