//
//  AllBehaviorViewController.swift
//  UIDynamicBehaivor
//
//  Created by Oleg Tverdokhleb on 05/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class AllBehaviorViewController: UIViewController {
  
  var arrayBox = [UIView]()
  var animator: UIDynamicAnimator!
  var attachment: UIAttachmentBehavior!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.darkGrayColor()
    animator = UIDynamicAnimator(referenceView: self.view)
    
    for i in 0..<6 {
      let frame = CGRect(x: i * 60, y: 200, width: 30, height: 30)
      let box = UIView(frame: frame)
      box.backgroundColor = UIColor.greenColor()
      box.layer.cornerRadius = 15
      box.layer.masksToBounds = true
      self.view.addSubview(box)
      arrayBox.append(box)
    }
    
    let itemsBehavior = UIDynamicItemBehavior(items: arrayBox)
    itemsBehavior.angularResistance = 0.5
    itemsBehavior.density = 10
    itemsBehavior.elasticity = 0.6
    itemsBehavior.friction = 0.3
    itemsBehavior.resistance = 0.3
    animator.addBehavior(itemsBehavior)
    
    let gravity = UIGravityBehavior(items: arrayBox)
    animator.addBehavior(gravity)
    
    let collision = UICollisionBehavior(items: arrayBox)
    collision.collisionMode = .Everything
    collision.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collision)
    
    attachment = UIAttachmentBehavior(item: arrayBox.first!, attachedToAnchor: arrayBox.first!.center)
    attachment.anchorPoint = CGPoint(x: 150, y: 80)
    attachment.length = 10
    attachment.damping = 0.3
    attachment.frequency = 1
    animator.addBehavior(attachment)
    
    for i in 1..<arrayBox.count {
      let view = arrayBox[i]
      let attach = UIAttachmentBehavior(item: view, attachedToItem: arrayBox[i - 1])
      attach.length = 25
      attach.damping = 1
      attach.frequency = 3
      animator.addBehavior(attach)
    }
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan))
    self.view.addGestureRecognizer(pan)
  }
  
  func addPan(pan: UIGestureRecognizer) {
    
    if !animator.behaviors.contains(attachment) {
      animator.addBehavior(attachment)
    }
    
    let point = pan.locationInView(view)
    attachment.anchorPoint = point
    
    if pan.state == .Ended {
      animator.removeBehavior(attachment)
    }
  }
}




