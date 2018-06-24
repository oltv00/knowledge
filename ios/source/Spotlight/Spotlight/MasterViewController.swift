//
//  MasterViewController.swift
//  Spotlight
//
//  Created by Oleg Tverdokhleb on 20/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import SafariServices
import CoreSpotlight
import MobileCoreServices

class MasterViewController: UITableViewController, SFSafariViewControllerDelegate {
  
  //NSUserActivity
  //WebMarkup
  //Spotlight
  
  
  // MARK: - Properties
    
  let video = Data().video
  let urls = Data().urlVideo
  var favourites = [Int]()

  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib. 
    
    let defaults = UserDefaults.standard
    if let savedFavourites = defaults.object(forKey: "favourites") as? [Int] {
      favourites = savedFavourites
      print(favourites)
    }
    
    // Self Sizing Cell
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableViewAutomaticDimension
  }
 
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnSwipe = true
  }
  
  // MARK: - Helper funcs
  
  func makeAttributedString(_ title: String, _ subtitle: String) -> NSAttributedString {
    let titleAttributed = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline), NSForegroundColorAttributeName: UIColor.black]
    let subtitleAttributed = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline), NSForegroundColorAttributeName: UIColor.lightGray]
    let titleOut = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributed)
    let subtitleOut = NSAttributedString(string: subtitle, attributes: subtitleAttributed)
    titleOut.append(subtitleOut)
    return titleOut
  }
  
  func showVideo(index: Int) {
    if let url = URL(string: "https://youtu.be/\(urls[index])") {
      let sf = SFSafariViewController(url: url)
      //sf.delegate = self
      present(sf, animated: true, completion: nil)
    }
  }
  
  // MARK: - UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return video.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    let videos = video[indexPath.row]
    let title = videos[0]
    let subtitle = videos[1]
    let text = makeAttributedString(title, subtitle)
    cell.textLabel?.attributedText = text
    
    cell.accessoryType = favourites.contains(indexPath.row) ? .checkmark : .none
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showVideo(index: indexPath.row)
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let defaults = UserDefaults.standard
    
    let searchAction = UITableViewRowAction(style: .default, title: "Search") { [unowned self] (action, indexPath) in
      let menu = UIAlertController(title: nil, message: "Search using", preferredStyle: .actionSheet)
      
      let add = UIAlertAction(title: "Add Index Item", style: .default, handler: { (action) in
        self.favourites.append(indexPath.row)
        defaults.set(self.favourites, forKey: "favourites")
        tableView.reloadRows(at: [indexPath], with: .none)
        
        let videos = self.video[indexPath.row]
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributes.title = videos[0]
        attributes.contentDescription = videos[1]
        let item = CSSearchableItem(uniqueIdentifier: "\(indexPath.row)", domainIdentifier: "com.oltv00", attributeSet: attributes)
        item.expirationDate = Date.distantFuture
        CSSearchableIndex.default().indexSearchableItems([item], completionHandler: { (error) in
          if let error = error {
            print("Indexing error: \(error.localizedDescription)")
          } else {
            print("Search item successfully indexed!")
          }
        })
      })
      
      let delete = UIAlertAction(title: "Delete Index Item", style: .default, handler: { (action) in
        if let index = self.favourites.index(of: indexPath.row) {
          self.favourites.remove(at: index)
          defaults.set(self.favourites, forKey: "favourites")
          tableView.reloadRows(at: [indexPath], with: .none)
          
          CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(indexPath.row)"], completionHandler: { (error) in
            if let error = error {
              print("Deindexing error: \(error.localizedDescription)")
            } else {
              print("Search item successfully removed!")
            }
          })
        }

      })
      
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
      menu.addAction(add)
      menu.addAction(delete)
      menu.addAction(cancel)
      self.present(menu, animated: true, completion: nil)
    }
    
    searchAction.backgroundColor = UIColor.green
    
    return [searchAction]
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.alpha = 0.0
    UIView.animate(withDuration: 1.0) {
      cell.alpha = 1.0
    }
    
    let angle = 90.0 * CGFloat(M_PI / 180.0)
    let rotation = CATransform3DMakeRotation(angle, 0, 0, 1)
    cell.layer.transform = rotation
    
    UIView.animate(withDuration: 1.0) { 
      cell.layer.transform = CATransform3DIdentity
    }
  }
  
  // MARK: - SFSafariViewControllerDelegate
 
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    //dismiss(animated: true, completion: nil)
  }
  
}

