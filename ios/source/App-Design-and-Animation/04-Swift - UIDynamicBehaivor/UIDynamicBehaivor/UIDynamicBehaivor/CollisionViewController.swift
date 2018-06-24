//
//  CollisionViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CollisionViewController: UIViewController {
  
  var box1: UIView!
  var box2: UIView!
  var animator: UIDynamicAnimator!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    animator = UIDynamicAnimator(referenceView: view)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan))
    self.view.addGestureRecognizer(pan)
    
    box1 = UIView(frame: CGRectMake(80, 50, 80, 80))
    box1.backgroundColor = UIColor.redColor()
    box1.transform = CGAffineTransformRotate(box1.transform, CGFloat(-M_PI_4/2))
    box1.layer.cornerRadius = 40
    self.view.addSubview(box1)
    
    box2 = UIView(frame: CGRectMake(200, 50, 80, 80))
    box2.backgroundColor = UIColor.whiteColor()
    box2.transform = CGAffineTransformRotate(box2.transform, CGFloat(M_PI_4/2))
    self.view.addSubview(box2)
    
    addBehavior()
  }
  
  func addPan(pan: UIGestureRecognizer) {
    animator.removeAllBehaviors()
    box1.center = pan.locationInView(self.view)
    
    switch pan.state {
    case .Ended:
      addBehavior()
      
    default: break
    }
  }
  
  func addBehavior() {
    let gravity = UIGravityBehavior(items: [box1, box2])
    animator.addBehavior(gravity)
    
    let collision = UICollisionBehavior(items: [box1, box2])
    collision.collisionMode = .Everything
    collision.translatesReferenceBoundsIntoBoundary = true
    collision.collisionDelegate = nil
    animator.addBehavior(collision)
  }
}








