//
//  MenuViewController.swift
//  StreetsApp
//
//  Created by Oleg Tverdokhleb on 04/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  @IBOutlet weak var backgroundMaskView: UIView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var bottomView: UIView!
  @IBOutlet weak var userView: UIView!
  @IBOutlet weak var dialogView: UIView!
  
  var animator: UIDynamicAnimator!
  var attachmentBehavior: UIAttachmentBehavior!
  var snapBehavior: UISnapBehavior!
  
  var prevHandleViewCenter: CGPoint!
  
  // MARK: - View life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // Set Blur Effect
    addBlurEffect(backgroundMaskView, style: .Dark)
    addBlurEffect(headerView, style: .Dark)
    addBlurEffect(bottomView, style: .Dark)
    
    animator = UIDynamicAnimator(referenceView: view)
    snapBehavior = UISnapBehavior(item: dialogView, snapToPoint: view.center)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let scale = CGAffineTransformMakeScale(0.5, 0.5)
    let transform = CGAffineTransformMakeTranslation(0, -300)
    dialogView.transform = CGAffineTransformConcat(scale, transform)
    
    UIView.animateWithDuration(0.7) {
      self.dialogView.transform = CGAffineTransformIdentity
    }
  }
  
  // MARK: - Helper methods
  func addBlurEffect(view: UIView, style: UIBlurEffectStyle) {
    view.backgroundColor = UIColor.clearColor()
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    view.insertSubview(blurEffectView, atIndex: 0)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  // MARK: - Handle methods
  @IBAction func handlePanRecognizer(sender: UIGestureRecognizer) {
    
    let handleView = dialogView
    let location = sender.locationInView(view)
    let boxLocation = sender.locationInView(dialogView)
    
    switch sender.state {
    case .Began:
      animator.removeBehavior(snapBehavior)
      prevHandleViewCenter = dialogView.center
      
      let centerOffset = UIOffsetMake(
        boxLocation.x - CGRectGetMidX(handleView.bounds),
        boxLocation.y - CGRectGetMidY(handleView.bounds))
      
      attachmentBehavior = UIAttachmentBehavior(
        item: handleView,
        offsetFromCenter: centerOffset,
        attachedToAnchor: location)
      
      attachmentBehavior.frequency = 0
      animator.addBehavior(attachmentBehavior)
      
    case .Changed:
      attachmentBehavior.anchorPoint = location
      
    case .Ended:
      animator.removeBehavior(attachmentBehavior)
      snapBehavior = UISnapBehavior(item: handleView, snapToPoint: prevHandleViewCenter)
      animator.addBehavior(snapBehavior)
      
    default: break
    }
  }
}










