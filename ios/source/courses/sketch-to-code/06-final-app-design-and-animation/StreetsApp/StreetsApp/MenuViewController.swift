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
  @IBOutlet weak var dialogView: DesignView!
  @IBOutlet weak var shareView: AnimationView!
  @IBOutlet weak var shareButton: AnimationButton!
  
  @IBOutlet weak var twitterButton: AnimationButton!
  @IBOutlet weak var facebookButton: AnimationButton!
  @IBOutlet weak var instagramButton: AnimationButton!
  
  @IBOutlet weak var twitterLabel: AnimationLabel!
  @IBOutlet weak var facebookLabel: AnimationLabel!
  @IBOutlet weak var instagramLabel: AnimationLabel!
  @IBOutlet weak var maskButton: UIButton!
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var backgroundDialogView: UIImageView!
  @IBOutlet weak var dialogViewTitleLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  var animator: UIDynamicAnimator!
  var attachmentBehavior: UIAttachmentBehavior!
  var snapBehavior: UISnapBehavior!
  
  var prevHandleViewCenter: CGPoint!
  
  let data = getData()
  var countRecord = 0
  
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
    
    backgroundImageView.image = UIImage(named: data[countRecord]["image"]!)
    backgroundDialogView.image = UIImage(named: data[countRecord]["image"]!)
    avatarImageView.image = UIImage(named: data[countRecord]["avatar"]!)
    dialogViewTitleLabel.text = data[countRecord]["title"]
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
  
  func showMask() {
    maskButton.hidden = false
    maskButton.alpha = 0
    
    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { 
      self.maskButton.alpha = 1
      }, completion: nil)
  }
  
  func refreshView() {
    if countRecord < 0 { countRecord = 2 }
    if countRecord > 2 { countRecord = 0 }
    animator.removeAllBehaviors()
    
    snapBehavior = UISnapBehavior(item: dialogView, snapToPoint: view.center)
    attachmentBehavior.anchorPoint = view.center
    dialogView.center = prevHandleViewCenter
    viewDidAppear(true)
  }
  
  func delay(delay: Double, closure:() -> Void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
  }
  
  // MARK: - Action methods
  @IBAction func actionShareButton(sender: AnimationButton) {
    shareView.hidden = false
    shareView.nameAnimation = "FadeIn"
    shareView.animate()
    
    shareButton.nameAnimation = "Shake"
    shareButton.animate()
    
    showMask()
    
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveLinear, animations: {
      self.dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8)
      }, completion: nil)
    
    twitterButton.nameAnimation = "SlideRight"
    twitterButton.delay = 0.5
    twitterButton.animate()
    
    twitterLabel.nameAnimation = "FadeIn"
    twitterLabel.delay = 0.8
    twitterLabel.animate()
    
    instagramButton.nameAnimation = "SlideLeft"
    instagramButton.delay = 0.7
    instagramButton.animate()
    
    instagramLabel.nameAnimation = "FadeIn"
    instagramLabel.delay = 1.0
    instagramLabel.animate()
    
    facebookButton.nameAnimation = "SlideUp"
    facebookButton.delay = 0.9
    facebookButton.animate()
    
    facebookLabel.nameAnimation = "FadeIn"
    facebookLabel.delay = 1.2
    facebookLabel.animate()
    
    shareButton.enabled = false
  }
  
  @IBAction func actionMaskButton(sender: UIButton) {
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveLinear, animations: {
      self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
      self.maskButton.alpha = 0
      }, completion: nil)
    
    shareView.nameAnimation = "FadeOut"
    shareView.animate()
    
    shareButton.enabled = true
  }
  
  // MAKR: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "openPost" {
      let vc = segue.destinationViewController as! DetailViewController
      vc.index = countRecord
    }
  }
  
  // MARK: - Handle methods
  @IBAction func handlePanRecognizer(sender: UIPanGestureRecognizer) {
    
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
      
      let translate = sender.translationInView(view)
      
      if translate.x > 100 {
        countRecord += 1
        animator.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: [dialogView])
        gravity.gravityDirection = CGVectorMake(50, 0)
        animator.addBehavior(gravity)
        
        delay(0.4) { self.refreshView() }
      }
      
      if translate.x < -100 {
        countRecord -= 1
        animator.removeAllBehaviors()
        
        let gravity = UIGravityBehavior(items: [dialogView])
        gravity.gravityDirection = CGVectorMake(-50, 0)
        animator.addBehavior(gravity)
        
        delay(0.4) { self.refreshView() }
      }
      
    default: break
    }
  }
}










