//
//  DesignTextField.swift
//  05-Swift - MoreAnimation-IBDesignable-IBInspectable
//
//  Created by Oleg Tverdokhleb on 10/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

@IBDesignable public class DesignTextField: AnimationTextField {
  
  @IBInspectable var placeholderColor: UIColor = UIColor.clearColor() {
    didSet {
      attributedPlaceholder = NSAttributedString(
        string: placeholder!,
        attributes: [NSForegroundColorAttributeName: placeholderColor])
      layoutSubviews()
    }
  }
  
  @IBInspectable var letfPadding: CGFloat = 0 {
    didSet {
      let padding = UIView(frame: CGRect(x: 0, y: 0, width: letfPadding, height: 0))
      leftViewMode = .Always
      leftView = padding
    }
  }
  
  @IBInspectable var rightPadding: CGFloat = 0 {
    didSet {
      let padding = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 0))
      rightViewMode = .Always
      rightView = padding
    }
  }
  
  @IBInspectable var sidePadding: CGFloat = 0 {
    didSet {
      let padding = UIView(frame: CGRect(x: 0, y: 0, width: sidePadding, height: sidePadding))

      rightViewMode = .Always
      leftViewMode = .Always
      
      leftView = padding
      rightView = padding
    }
  }

}
