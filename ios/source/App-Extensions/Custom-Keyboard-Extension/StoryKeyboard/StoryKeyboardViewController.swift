//
//  KeyboardViewController.swift
//  StoryKeyboard
//
//  Created by Oleg Tverdokhleb on 06/10/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class StoryKeyboardViewController: UIInputViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var numberSet: UIStackView!
  @IBOutlet weak var charSet: UIStackView!
  @IBOutlet weak var QWE: UIStackView!
  @IBOutlet weak var ASD: UIStackView!
  @IBOutlet weak var ZXC: UIStackView!
  @IBOutlet weak var System: UIStackView!
  
  @IBOutlet weak var shiftButton: UIButton!
  var shiftStatus: Int! // 0 - off, 1 - on, 2 - caps lock
  
  // MARK: View life cycles
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    charSet.isHidden = true
    shiftStatus = 1
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated
  }
  
  // MARK: - Actions
  
  @IBAction func actionNextKeyboard(_ sender: UIButton) {
    advanceToNextInputMode()
  }
  
  @IBAction func actionShift(_ sender: UIButton) {
    shiftStatus = shiftStatus > 0 ? 0 : 1
    shiftChangeQWEASDZXC()
  }
  
  @IBAction func actionKey(_ sender: UIButton) {
    if let text = sender.titleLabel?.text {
      textDocumentProxy.insertText(text)
    }
    
    if shiftStatus == 1 {
      actionShift(shiftButton)
    }
    
    UIView.animate(withDuration: 0.125, animations: {
      sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
      }) { (finished) in
        sender.transform = CGAffineTransform.identity
    }
  }
  
  @IBAction func actionBackspace(_ sender: UIButton) {
    textDocumentProxy.deleteBackward()
  }
  
  @IBAction func actionCharSet(_ sender: UIButton) {
    if sender.titleLabel?.text == "!@#" {
      charSet.isHidden = false
      numberSet.isHidden = true
      sender.setTitle("123", for: .normal)
    } else {
      charSet.isHidden = true
      numberSet.isHidden = false
      sender.setTitle("!@#", for: .normal)
    }
  }
  
  @IBAction func actionReturn(_ sender: UIButton) {
    textDocumentProxy.insertText("\n")
  }
  
  @IBAction func actionSpace(_ sender: UIButton) {
    textDocumentProxy.insertText(" ")
  }
  
  // MARK: - Handle
  
  @IBAction func handleDoubleTap(_ sender: UITapGestureRecognizer) {
    shiftStatus = 2
    shiftChangeQWEASDZXC()
  }
  
  @IBAction func handleTrippleTap(_ sender: UITapGestureRecognizer) {
    shiftStatus = 0
    actionShift(shiftButton)
  }
  
  // MARK: - Helper funcs
  
  func shiftChange(containerView: UIStackView) {
    for view in containerView.subviews {
      if let button = view as? UIButton {
        let buttonTitle = button.titleLabel?.text
        if shiftStatus == 0 {
          let text = buttonTitle?.lowercased()
          button.setTitle(text, for: .normal)
        } else {
          let text = buttonTitle?.uppercased()
          button.setTitle(text, for: .normal)
        }
      }
    }
  }
  
  func shiftChangeQWEASDZXC() {
    shiftChange(containerView: QWE)
    shiftChange(containerView: ASD)
    shiftChange(containerView: ZXC)
  }
  
  // MARK: - UITextInputDelegate
  
  override func textWillChange(_ textInput: UITextInput?) {
    // The app is about to change the document's contents. Perform any preparation here.
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    // The app has just changed the document's contents, the document context has been updated.
    
  }
  
}
