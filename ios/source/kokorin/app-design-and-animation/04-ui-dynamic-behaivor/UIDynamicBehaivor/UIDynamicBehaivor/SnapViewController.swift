//
//  SnapViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
  
  var box: UIView!
  var animator: UIDynamicAnimator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    animator = UIDynamicAnimator(referenceView: view)
    
    box = UIView(frame: CGRect(x: 100, y: 200, width: 80, height: 80))
    box.backgroundColor = UIColor.lightGrayColor()
    self.view.addSubview(box)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan))
    self.view.addGestureRecognizer(pan)
  }
  
  func addPan(pan: UIGestureRecognizer) {
    let point = pan.locationInView(view)
    
    switch pan.state {
    case let state where state == .Began || state == .Cancelled:
      animator.removeAllBehaviors()
    
    case .Changed:
      box.center = point
      
    case .Ended:
      
      let size = self.view.frame.size
      let lead = point.x
      let tail = size.width - point.x
      let bottom = size.height - point.y
      
      let edge = box.frame.size.width / 2.0
      
      var newPoint = CGPoint()
      if lead < tail {
        if lead < bottom {
          newPoint = CGPoint(x: edge, y: point.y)
        } else {
          newPoint = CGPoint(x: point.x, y: size.height - edge)
        }
      } else {
        if tail < bottom {
          newPoint = CGPoint(x: size.width - edge, y: point.y)
        } else {
          newPoint = CGPoint(x: point.x, y: size.height - edge)
        }
      }
      
      let snap = UISnapBehavior(item: box, snapToPoint: newPoint)
      snap.damping = 0.55
      animator.addBehavior(snap) 
      
    default: break
    }
  }
}
