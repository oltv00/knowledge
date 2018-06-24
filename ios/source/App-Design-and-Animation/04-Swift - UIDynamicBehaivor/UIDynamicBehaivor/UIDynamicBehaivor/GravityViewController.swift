//
//  GravityViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
  
  var square: UIView!
  var animator: UIDynamicAnimator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    animator = UIDynamicAnimator(referenceView: view)
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    square = UIView(frame: CGRectMake(140, 200, 50, 50))
    square.backgroundColor = UIColor.lightGrayColor()
    self.view.addSubview(square)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan))
    self.view.addGestureRecognizer(pan)
  }
  
  func addPan(pan: UIGestureRecognizer) {
    animator.removeAllBehaviors()
    square.center = pan.locationInView(self.view)
    
    switch pan.state {
    case .Ended:
      let gravity = UIGravityBehavior(items: [square])
      animator.addBehavior(gravity)
    default: break
    }
  }
}
