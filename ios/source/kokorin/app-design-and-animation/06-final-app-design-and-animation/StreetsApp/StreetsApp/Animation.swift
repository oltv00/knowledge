//
//  Animation.swift
//  05-Swift - MoreAnimation-IBDesignable-IBInspectable
//
//  Created by Oleg Tverdokhleb on 09/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit


// MARK: - Animatable protocol
@objc public protocol Animatable {
  
  // Animation
  var startAnimation: Bool { get set }
  var nameAnimation: String { get set }
  var curve: String { get set }
  var x: CGFloat { get set }
  var y: CGFloat { get set }
  var force: CGFloat { get set }
  var animateForm: Bool { get set }
  var duration: CGFloat { get set }
  var delay: CGFloat { get set }
  var damping: CGFloat { get set }
  var velocity: CGFloat { get set }
  var scaleX: CGFloat { get set }
  var scaleY: CGFloat { get set }
  var opacity: CGFloat { get set }
  var repeatCount: CGFloat { get set }
  
  // UIView
  var transform: CGAffineTransform { get set }
  var alpha: CGFloat { get set }
  var layer: CALayer { get }
  
  func animate()
}

// MARK: - Animation class
public class Animation: NSObject {
  
  // MARK: - Initialization
  private unowned var view: Animatable
  
  init(_ view: Animatable) {
    self.view = view
    super.init()
    generalInit()
  }
  
  func generalInit() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didBecomeActiveNotification), name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
  // MARK: - Notification
  func didBecomeActiveNotification(notification: NSNotification) {
    if shouldAnimateAfterActive == true {
      animate()
      shouldAnimateAfterActive = false
    }
  }
  
  // MARK: - Animation variables
  private var startAnimation: Bool {
    get { return self.view.startAnimation }
    set { self.view.startAnimation = newValue }
  }
  private var nameAnimation: String {
    get { return self.view.nameAnimation }
    set { self.view.nameAnimation = newValue }
  }
  private var curve: String {
    get { return self.view.curve }
    set { self.view.curve = newValue }
  }
  private var x: CGFloat {
    get { return self.view.x }
    set { self.view.x = newValue }
  }
  private var y: CGFloat {
    get { return self.view.y }
    set { self.view.y = newValue }
  }
  private var force: CGFloat {
    get { return self.view.force }
    set { self.view.force = newValue }
  }
  private var animateForm: Bool {
    get { return self.view.animateForm }
    set { self.view.animateForm = newValue }
  }
  private var duration: CGFloat {
    get { return self.view.duration }
    set { self.view.duration = newValue }
  }
  private var delay: CGFloat {
    get { return self.view.delay }
    set { self.view.delay = newValue }
  }
  private var damping: CGFloat {
    get { return self.view.damping }
    set { self.view.damping = newValue }
  }
  private var velocity: CGFloat {
    get { return self.view.velocity }
    set { self.view.velocity = newValue }
  }
  private var scaleX: CGFloat {
    get { return self.view.scaleX }
    set { self.view.scaleX = newValue }
  }
  private var scaleY: CGFloat {
    get { return self.view.scaleY }
    set { self.view.scaleY = newValue }
  }
  private var opacity: CGFloat {
    get { return self.view.opacity }
    set { self.view.opacity = newValue }
  }
  private var repeatCount: CGFloat {
    get { return self.view.repeatCount }
    set { self.view.repeatCount = newValue }
  }
  private var shouldAnimateAfterActive = false
  
  // MARK: - UIView variables
  private var transform: CGAffineTransform {
    get { return self.view.transform }
    set { self.view.transform = newValue }
  }
  private var alpha: CGFloat {
    get { return self.view.alpha }
    set { self.view.alpha = newValue }
  }
  private var layer: CALayer {
    return self.view.layer
  }
  
  enum AnimationPreset: String {
    case SlideLeft = "SlideLeft"
    case SlideRight = "SlideRight"
    case SlideUp = "SlideUp"
    case FadeIn = "FadeIn"
    case FadeOut = "FadeOut"
    case ZoomIn = "ZoomIn"
    case ZoomOut = "ZoomOut"
    case SqueezeLeft = "SqueezeLeft"
    case SqueezeRight = "SqueezeRight"
    case Shake = "Shake"
    case Morph = "Morph"
  }
  
  enum AnimationCurve: String {
    case EaseInOut = "EaseInOut"
    case EaseIn = "EaseIn"
    case EaseOut = "EaseOut"
    case Linear = "Linear"
    case EaseInOutCirc = "EaseInOutCirc"
    case EaseOutCirc = "EaseOutCirc"
  }
  
  // MARK: - Animation methods
  func animatePreset() {
    alpha = 1
    if let animation = AnimationPreset(rawValue: nameAnimation) {
      switch animation {
      case .SlideLeft: x = 300 * force
      case .SlideRight: x = -300 * force
      case .SlideUp: y = 300 * force
      case .FadeIn:
        opacity = 0
      case .FadeOut:
        animateForm = false
        opacity = 0
      case .ZoomIn:
        scaleX = 2 * force
        scaleY = 2 * force
      case .ZoomOut:
        animateForm = false
        opacity = 0
        scaleX = 2 * force
        scaleY = 2 * force
      case .SqueezeLeft:
        x = 300
        scaleX = 3 * force
      case .SqueezeRight:
        x = -300
        scaleX = 3 * force
      case .Shake:
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 5 * force, -5 * force, 5 * force, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        animation.timingFunction = animateCurveTimingFunction(curve)
        animation.duration = CFTimeInterval(duration)
        animation.additive = true
        animation.repeatCount = Float(repeatCount)
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        layer.addAnimation(animation, forKey: "shake")
      case .Morph:
        let morphX = CAKeyframeAnimation()
        morphX.keyPath = "transform.scale.x"
        morphX.values = [1, 1.3 * force, 0.7, 1.3 * force, 1]
        morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        morphX.timingFunction = animateCurveTimingFunction(curve)
        morphX.duration = CFTimeInterval(duration)
        morphX.repeatCount = Float(repeatCount)
        morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        layer.addAnimation(morphX, forKey: "morphX")
        
        let morphY = CAKeyframeAnimation()
        morphY.keyPath = "transform.scale.y"
        morphY.values = [1, 0.7, 1.3 * force, 0.7, 1]
        morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        morphY.timingFunction = animateCurveTimingFunction(curve)
        morphY.duration = CFTimeInterval(duration)
        morphY.repeatCount = Float(repeatCount)
        morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        layer.addAnimation(morphY, forKey: "morphY")
      }
    }
  }
  
  func animateCurveTimingFunction(curve: String) -> CAMediaTimingFunction {
    if let curve = AnimationCurve(rawValue: curve) {
      switch curve {
      case .EaseIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
      case .EaseInOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      case .EaseOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
      case .Linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
      case .EaseOutCirc: return CAMediaTimingFunction(controlPoints: 0.75, 0.82, 0.165, 1)
      case .EaseInOutCirc: return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
      }
    }
    return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
  }
  
  func animationOptions(curve: String) -> UIViewAnimationOptions {
    if let curve = AnimationCurve(rawValue: curve) {
      switch curve {
      case .EaseIn: return .CurveEaseIn
      case .EaseInOut: return .CurveEaseInOut
      case .EaseOut: return .CurveEaseOut
      default: break
      }
    }
    return .CurveLinear
  }
  
  public func animate() {
    animateForm = true
    animatePreset()
    configureView()
  }
  
  func configureView() {
    if animateForm {
      let translate = CGAffineTransformMakeTranslation(self.x, self.y)
      let scale = CGAffineTransformMakeScale(self.scaleX, self.scaleY)
      self.transform = CGAffineTransformConcat(translate, scale)
      self.alpha = self.opacity
    }
    
    UIView.animateWithDuration(
      NSTimeInterval(duration),
      delay: NSTimeInterval(delay),
      usingSpringWithDamping: damping,
      initialSpringVelocity: velocity,
      options: animationOptions(curve),
      animations: { [weak self] in
        
        if let _self = self {
          if _self.animateForm {
            _self.transform = CGAffineTransformIdentity
            _self.alpha = 1
          } else {
            let translate = CGAffineTransformMakeTranslation(_self.x, _self.y)
            let scale = CGAffineTransformMakeScale(_self.scaleX, _self.scaleY)
            _self.transform = CGAffineTransformConcat(translate, scale)
            _self.alpha = _self.opacity
          }
        }
        
      }, completion: { [weak self] (finished) in
        
        self?.resetAll()
        
      })
  }
  
  func resetAll() {
    x = 0
    y = 0
    nameAnimation = ""
    damping = 0.7
    velocity = 0.7
    delay = 0
    duration = 0.7
    repeatCount = 1
  }
  
  public func customDidMoveToWindow() {
    if startAnimation {
      if UIApplication.sharedApplication().applicationState != .Active {
        shouldAnimateAfterActive = true
        return
      }
      alpha = 0
      animate()
    }
  }
  
}
