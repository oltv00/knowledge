//
//  ViewController.swift
//  Test-Alfa
//
//  Created by Oleg Tverdokhleb on 14/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
  
  // MARK: - @IBOutlet
  
  // MARK: - instance variables
  
  let realm = try! Realm()
  lazy var articles: Results<Article> = { self.realm.objects(Article.self) }()
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Add timer to runloop
    let timer = Timer(timeInterval: 300.0, target: self, selector: #selector(getNewsFromServer), userInfo: nil, repeats: true)
    RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
    
    // Realm file link!
    print(Realm.Configuration.defaultConfiguration.fileURL!)
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60.0
    
    // first launch test
    if UserDefaults.standard.value(forKey: "isFirstLaunch") as? Bool == nil {
      UserDefaults.standard.set(false, forKey: "isFirstLaunch")
      getNewsFromServer()
    }
    
    // add refresh control
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(actionRefreshControl), for: .valueChanged)
    tableView.refreshControl = refresh
  }
  
  func getNewsFromServer() {
    ServerManager.shared.getNews {
      // load data from realm database
      self.articles = self.realm.objects(Article.self)
      
      self.tableView.reloadData()
      self.tableView.refreshControl?.endRefreshing()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Action
  
  func actionRefreshControl() {
    getNewsFromServer()
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let article = articles[indexPath.row]
    cell.textLabel?.text = article.title
    cell.detailTextLabel?.text = article.date
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedArticleViewController") as! DetailedArticleViewController
    let article = articles[indexPath.row]
    vc.url = URL(string: article.link!)
    show(vc, sender: nil)
  }
}

