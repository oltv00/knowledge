//
//  AttachmentViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {
  
  var box: UIView!
  var animator: UIDynamicAnimator!
  var attachment: UIAttachmentBehavior!
  
  var kongCenter: UIImageView!
  var rope: CAShapeLayer!
  
  var isBox = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    animator = UIDynamicAnimator(referenceView: view)
    
    box = UIView(frame: CGRectMake(100, 100, 80, 80))
    box.backgroundColor = UIColor.lightGrayColor()
    self.view.addSubview(box)
    
    // CA init
    kongCenter = UIImageView(image: UIImage(named: "AttachmentPoint_Mask"))
    kongCenter.frame = CGRectMake(0, 0, 10, 10)
    kongCenter.center = CGPoint(x: box.bounds.size.width / 2 - 30, y: box.bounds.size.height / 2 - 30)
    kongCenter.backgroundColor = UIColor.lightGrayColor()
    kongCenter.layer.borderWidth = 2
    kongCenter.layer.borderColor = UIColor.whiteColor().CGColor
    kongCenter.layer.cornerRadius = 5
    kongCenter.layer.masksToBounds = true
    box.addSubview(kongCenter)
    
    box.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
    
    let gravity = UIGravityBehavior(items: [box])
    animator.addBehavior(gravity)
    attachment = UIAttachmentBehavior(
      item: box,
      offsetFromCenter: UIOffsetMake(-30, -30),
      attachedToAnchor: CGPointMake(CGRectGetMidX(self.view.bounds), 120)
    )
    
    attachment.length = isBox ? 60 : 120
    attachment.damping = 0.1
    attachment.frequency = isBox ? 0.6 : 0
    animator.addBehavior(attachment)
    
    let collision = UICollisionBehavior(items: [box])
    collision.collisionMode = .Everything
    collision.translatesReferenceBoundsIntoBoundary = true
    collision.collisionDelegate = nil
    animator.addBehavior(collision)
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan))
    self.view.addGestureRecognizer(pan)
  }
  
  func addPan(pan: UIGestureRecognizer) {
    let point = pan.locationInView(self.view)
    attachment.anchorPoint = point
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if rope == nil {
      rope = CAShapeLayer()
      rope.fillColor = UIColor.clearColor().CGColor
      rope.lineJoin = kCALineJoinRound
      rope.lineWidth = 2.0
      rope.strokeColor = UIColor.whiteColor().CGColor
      rope.strokeEnd = 1.0
      self.view.layer.addSublayer(rope)
    }
    
    let point = self.view.convertPoint(kongCenter.center, fromView: box)
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(attachment.anchorPoint)
    bezierPath.addLineToPoint(point)
    rope.path = bezierPath.CGPath
  }
  
  deinit {
    box.removeObserver(self, forKeyPath: "center")
  }
}
