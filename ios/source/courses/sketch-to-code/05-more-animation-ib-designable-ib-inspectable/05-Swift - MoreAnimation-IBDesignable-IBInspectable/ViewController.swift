//
//  ViewController.swift
//  05-Swift - MoreAnimation-IBDesignable-IBInspectable
//
//  Created by Oleg Tverdokhleb on 09/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var boxView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //slideLeftRight()
    //zoomInOut()
    //squeezeLeftRight()
    //fadeInOut()
    //shakeAnimation()
    //morphAnimation()
    //shakeAnimationWithControlPoints()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // 1 - SlideRight and SlideLeft
  func slideLeftRight() {
    let force: CGFloat = 1
    let translate = CGAffineTransformMakeTranslation(-300 * force, 0)
    boxView.transform = translate
    
    UIView.animateWithDuration(1.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: {
      
      self.boxView.transform = CGAffineTransformIdentity
      
      }, completion: nil)
  }
  
  // 2 - ZoomIn and zoomOut
  func zoomInOut() {
    let force: CGFloat = 1
    let scale = CGAffineTransformMakeScale(0 * force, 0 * force)
    boxView.transform = scale
    
    UIView.animateWithDuration(1.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: {
      
      self.boxView.transform = CGAffineTransformIdentity
      
      }, completion: nil)
    
  }

  // 3 - SqueezeLeft and Right
  func squeezeLeftRight() {
    
    let force: CGFloat = 1
    let scale = CGAffineTransformMakeScale(0.5 * force, 0.5 * force)
    let translate = CGAffineTransformMakeTranslation(-300 * force, 0)
    boxView.transform = CGAffineTransformConcat(scale, translate)
    
    UIView.animateWithDuration(1.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: { 
      
      self.boxView.transform = CGAffineTransformIdentity
      
      }, completion: nil)
  }
  
  // 4 - fadeIn, fadeOut
  func fadeInOut() {
    
    let opacity: CGFloat = 0
    boxView.alpha = opacity
    
    UIView.animateWithDuration(1.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .CurveEaseInOut, animations: {
      
      self.boxView.alpha = 1.0
      
      }, completion: nil)
  }
  
  // 5 - Shake
  func shakeAnimation() {
    
    let force: CGFloat = 5
    
    let shake = CAKeyframeAnimation()
    shake.keyPath = "position.x"
    shake.values = [0, 30 * force, -30 * force, 30 * force, 0]
    shake.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
    shake.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    shake.duration = 2
    shake.additive = true
    shake.repeatCount = 1
    shake.beginTime = CACurrentMediaTime() + 0
    self.boxView.layer.addAnimation(shake, forKey: nil)
    
  }
  
  // 5.5 - Shake with control points - easings.net
  func shakeAnimationWithControlPoints() {
    
    let force: CGFloat = 5
    
    let shake = CAKeyframeAnimation()
    shake.keyPath = "position.x"
    shake.values = [0, 30 * force, -30 * force, 30 * force, 0]
    shake.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
    shake.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
    shake.duration = 2
    shake.additive = true
    shake.repeatCount = 1
    shake.beginTime = CACurrentMediaTime() + 0
    self.boxView.layer.addAnimation(shake, forKey: nil)
    
  }
  
  // 6 - Morph X and Y
  func morphAnimation() {
    let force: CGFloat = 1
    
    let morphX = CAKeyframeAnimation()
    morphX.keyPath = "transform.scale.x"
    morphX.values = [1, 1.3 * force, 0.7, 1.3 * force, 1]
    morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
    morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    morphX.duration = 5
    morphX.repeatCount = 1
    morphX.beginTime = CACurrentMediaTime() + 0
    self.boxView.layer.addAnimation(morphX, forKey: nil)
    
    let morphY = CAKeyframeAnimation()
    morphY.keyPath = "transform.scale.y"
    morphY.values = [1, 0.7, 1.3 * force, 0.7, 1]
    morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
    morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    morphY.duration = 5
    morphY.repeatCount = 1
    morphY.beginTime = CACurrentMediaTime() + 0
    self.boxView.layer.addAnimation(morphY, forKey: nil)
    
    }
}

