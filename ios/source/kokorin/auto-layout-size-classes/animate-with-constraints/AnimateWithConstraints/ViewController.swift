//
//  ViewController.swift
//  AnimateWithConstraints
//
//  Created by Oleg Tverdokhleb on 18/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  enum ViewState {
    case min, norm, big
  }
  
  @IBOutlet weak var resizeView: UIView!
  @IBOutlet weak var height: NSLayoutConstraint!
  @IBOutlet weak var width: NSLayoutConstraint!
  
  var viewState = ViewState.min
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func actionResize(_ sender: UIButton) {
    switch viewState {
    case .min:
      viewState = .norm
      let h = view.frame.height - 40
      let w = resizeView.frame.width
      animate(h, w)
      
    case .norm:
      viewState = .big
      let h = resizeView.frame.height
      let w = view.frame.width - 32
      animate(h, w)
      
    case .big:
      viewState = .min
      let h: CGFloat = 100
      let w: CGFloat = 100
      animate(h, w)
    }
  }
  
  func animate(_ h: CGFloat, _ w: CGFloat) {
    UIView.animate(withDuration: 0.7) {
      self.height.constant = h
      self.width.constant = w
      self.view.layoutIfNeeded()
    }
  }


}

