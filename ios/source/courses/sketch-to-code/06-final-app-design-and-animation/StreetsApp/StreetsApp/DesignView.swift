//
//  DesignView.swift
//  05-Swift - MoreAnimation-IBDesignable-IBInspectable
//
//  Created by Oleg Tverdokhleb on 10/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

@IBDesignable public class DesignView: AnimationView {

  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet { layer.cornerRadius = cornerRadius }
  }
  @IBInspectable public var borderColor: UIColor = UIColor.clearColor() {
    didSet { layer.borderColor = borderColor.CGColor }
  }
  @IBInspectable public var borderWidth: CGFloat = 0 {
    didSet { layer.borderWidth = borderWidth }
  }

}
