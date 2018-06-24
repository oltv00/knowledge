//
//  CodeViewController.swift
//  Auto-Layout-Size-Classes
//
//  Created by Oleg Tverdokhleb on 18/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
  
  var view1: UIView!
  var view2: UIView!
  var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    initViews()
    createConstraints()
    
  }
  
  func initViews() {
    
    // Init
    view1 = UIView()
    view2 = UIView()
    imageView = UIImageView()
    
    // Prepare auto layout
    view1.translatesAutoresizingMaskIntoConstraints = false
    view2.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    // Set background color
    view1.backgroundColor = UIColor.lightGray
    view2.backgroundColor = UIColor.darkGray
    imageView.backgroundColor = UIColor.white
    
    // Additional option
    imageView.image = UIImage(named: "meta-tags")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 20.0
    
    // Add to the superview
    view.addSubview(view1)
    view.addSubview(view2)
    view.addSubview(imageView)
  }
  
  func createConstraints() {
    
    // Create view1
    let pinLeftView1 = NSLayoutConstraint(item: view1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
    let pinTopView1 = NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
    let pinRightView1 = NSLayoutConstraint(item: view1, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
    let verticalView1 = NSLayoutConstraint(item: view1, attribute: .bottom, relatedBy: .equal, toItem: view2, attribute: .top, multiplier: 1.0, constant: 0)
    let heightView1 = NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.65, constant: 0)
    
    // Create view2
    let pinLeftView2 = NSLayoutConstraint(item: view2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
    let pinBottomView2 = NSLayoutConstraint(item: view2, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
    let pinRightView2 = NSLayoutConstraint(item: view2, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
    
    // Create ImageView
    let centerXImage = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view1, attribute: .centerX, multiplier: 1.0, constant: 0)
    let centerYImage = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view1, attribute: .centerY, multiplier: 1.0, constant: 0)
    let widthImage = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 0.0, constant: 200)
    let heightImage = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 0.0, constant: 200)
    
    view.addConstraints([pinLeftView1, pinTopView1, pinRightView1, verticalView1, heightView1, pinLeftView2, pinBottomView2, pinRightView2, centerXImage, centerYImage, widthImage, heightImage])
  }
}





















