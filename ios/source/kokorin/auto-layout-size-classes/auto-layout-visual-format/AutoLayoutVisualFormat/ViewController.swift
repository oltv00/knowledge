//
//  ViewController.swift
//  AutoLayoutVisualFormat
//
//  Created by Oleg Tverdokhleb on 18/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var moveImageView: UIImageView!
  
  var headerView: UIView!
  var titleLabel: UILabel!
  var descLabel: UILabel!
  var imageView: UIImageView!
  var buttonStart: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
    createVFL()
  }

  func initViews() {
    
    headerView = UIView()
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.backgroundColor = UIColor.lightGray
    view.addSubview(headerView)
    
    titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.systemFont(ofSize: 10)
    titleLabel.numberOfLines = 0
    titleLabel.preferredMaxLayoutWidth = 150
    titleLabel.backgroundColor = UIColor.yellow
    titleLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    headerView.addSubview(titleLabel)
    
    descLabel = UILabel()
    descLabel.translatesAutoresizingMaskIntoConstraints = false
    descLabel.font = UIFont.systemFont(ofSize: 14)
    descLabel.backgroundColor = UIColor.green
    descLabel.text = "Author: Konstantin"
    headerView.addSubview(descLabel)
    
    imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = UIColor.red
    headerView.addSubview(imageView)
    
    buttonStart = UIButton()
    buttonStart.translatesAutoresizingMaskIntoConstraints = false
    buttonStart.setTitle("Start", for: .normal)
    headerView.addSubview(buttonStart)
    
    DispatchQueue.global(qos: .default).async {
      var data: Data!
      do {
        let url = URL(string: "http://admiral-c.com.ua/images/slides/TO.png")
        data = try Data(contentsOf: url!)
      } catch {
        print(error)
      }
      if let data = data {
        DispatchQueue.main.async {
          let carImage = UIImage(data: data)
          self.moveImageView.image = carImage
        }
      }
    }
  }
  
  func createVFL() {
    
    let views = ["headerView" : headerView,
                 "titleLabel" : titleLabel,
                 "descLabel" : descLabel,
                 "imageView" : imageView,
                 "buttonStart" : buttonStart]
    
    let metrics = ["imageWidth" : 200,
                   "imageHeight" : 300,
                   "padding" : 15]
    
    //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerView]|", options: [], metrics: metrics, views: views))
    //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[headerView]", options: [], metrics: metrics, views: views))
    //headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[imageView(imageWidth)]-padding-[titleLabel]-padding-|", options: [], metrics: metrics, views: views))
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}


















