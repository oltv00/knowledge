//
//  PushViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
  
  var box: UIView!
  var rope: CAShapeLayer!
  var animator: UIDynamicAnimator!
  var push: UIPushBehavior!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
    animator = UIDynamicAnimator(referenceView: view)
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    box = UIView(frame: CGRectMake(100, 200, 80, 80))
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
      
      if rope == nil {
        rope = CAShapeLayer()
        rope.fillColor = UIColor.clearColor().CGColor
        rope.lineJoin = kCALineJoinRound
        rope.lineWidth = 2.0
        rope.strokeColor = UIColor.whiteColor().CGColor
        rope.strokeEnd = 1.0
        self.view.layer.addSublayer(rope)
      }
      
      let bezierPath = UIBezierPath()
      bezierPath.moveToPoint(point)
      bezierPath.addLineToPoint(self.view.center)
      rope.path = bezierPath.CGPath
      
    case .Ended:
      
      rope.removeFromSuperlayer()
      rope = nil
      
      let origin = self.view.center
      
      var distanceForMagnitude = sqrt(pow(origin.x - point.x, 2) + pow(origin.y - point.y, 2))
      let angle = atan2(origin.y - point.y, origin.x - point.x)
      
      distanceForMagnitude = max(distanceForMagnitude, 10)
      
      push = UIPushBehavior(items: [box], mode: .Instantaneous)
      push.magnitude = distanceForMagnitude / 40
      push.angle = angle
      push.active = true
      animator.addBehavior(push)
      
    default: break
    }
  }
}
