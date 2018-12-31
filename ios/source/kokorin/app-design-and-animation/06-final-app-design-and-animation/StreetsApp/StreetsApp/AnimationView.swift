//
//  AnimationView.swift
//  05-Swift - MoreAnimation-IBDesignable-IBInspectable
//
//  Created by Oleg Tverdokhleb on 10/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

public class AnimationView: UIView, Animatable {
  @IBInspectable public var startAnimation: Bool = false
  @IBInspectable public var nameAnimation: String = ""
  @IBInspectable public var curve: String = ""
  @IBInspectable public var x: CGFloat = 0
  @IBInspectable public var y: CGFloat = 0
  @IBInspectable public var force: CGFloat = 1
  @IBInspectable public var duration: CGFloat = 0.7
  @IBInspectable public var delay: CGFloat = 0
  @IBInspectable public var damping: CGFloat = 0.7
  @IBInspectable public var velocity: CGFloat = 0.7
  @IBInspectable public var scaleX: CGFloat = 1
  @IBInspectable public var scaleY: CGFloat = 1
  @IBInspectable public var repeatCount: CGFloat = 1

  public var animateForm: Bool = false
  public var opacity: CGFloat = 1
  
  lazy private var anim: Animation = Animation(self)
  
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    self.anim.customDidMoveToWindow()
  }
  
  public func animate() {
    self.anim.animate()
  }
}
