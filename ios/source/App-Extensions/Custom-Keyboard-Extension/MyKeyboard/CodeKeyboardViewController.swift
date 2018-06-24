//
//  KeyboardViewController.swift
//  MyKeyboard
//
//  Created by Oleg Tverdokhleb on 29/09/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CodeKeyboardViewController: UIInputViewController {
  
  // MARK: - Constants
    
  let topConstraintConstant: CGFloat = 1
  let bottomConstraintConstant: CGFloat = 0
  let leftConstraintConstant: CGFloat = 1
  let rightConstraintConstant: CGFloat = -1
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let buttonTitles0 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    let buttonTitles1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let buttonTitles2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let buttonTitles3 = ["CL", "Z", "X", "C", "V", "B", "N", "M", "BS"]
    let buttonTitles4 = ["KB", "SPACE", ".", "RETURN"]
    let titles = [buttonTitles0, buttonTitles1, buttonTitles2, buttonTitles3, buttonTitles4]
    var rows = [UIView]()
    
    for title in titles {
      let row = createRowOfButtons(buttonTitles: title)
      row.translatesAutoresizingMaskIntoConstraints = false
      rows.append(row)
      self.view.addSubview(row)
    }
    
    addKeyboardViewConstraint(inputView: view, rowViews: rows)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    print("updateViewConstraints")
    
    // Add custom view sizing constraints here
  }
  
  // MARK: - Helper methods
  
  func createRowOfButtons(buttonTitles: [String]) -> UIView {
    var buttons = [UIButton]()
    
    let keyboardRowView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
    
    for buttonTitle in buttonTitles {
      let button = createButtonWithTitle(title: buttonTitle)
      buttons.append(button)
      keyboardRowView.addSubview(button)
    }
    addButtonConstraints(buttons: buttons, onView: keyboardRowView)
    return keyboardRowView
  }
  
  func createButtonWithTitle(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    button.setTitle(title, for: .normal)
    button.sizeToFit()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
    button.setTitleColor(UIColor.darkGray, for: .normal)
    
    button.addTarget(self, action: #selector(actionTapButton), for: .touchUpInside)
    
    return button
  }
  
  func addButtonConstraints(buttons: [UIButton], onView view: UIView) {
    
    for (index, button) in buttons.enumerated() {
      let top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: topConstraintConstant)
      let bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: bottomConstraintConstant)
      var left = NSLayoutConstraint()
      var right = NSLayoutConstraint()
      
      if index == 0 {
        // if current button is first button
        let nextButton = buttons[index + 1]
        left = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: leftConstraintConstant)
        right = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1, constant: rightConstraintConstant)
        
      } else if index == buttons.count - 1 {
        // if current button is last button
        let prevButton = buttons[index - 1]
        left = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevButton, attribute: .right, multiplier: 1, constant: leftConstraintConstant)
        right = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: rightConstraintConstant)
        
        // add width constraint between buttons
        let firstButton = buttons[0]
        addButtonWidthConstraint(fromButton: firstButton, toButton: button, toView: view)
        
      } else {
        // if current button is between of other buttons
        let prevButton = buttons[index - 1]
        let nextButton = buttons[index + 1]
        left = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: prevButton, attribute: .right, multiplier: 1, constant: leftConstraintConstant)
        right = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: nextButton, attribute: .left, multiplier: 1, constant: rightConstraintConstant)
        
        // add width constraint between buttons
        let firstButton = buttons[0]
        addButtonWidthConstraint(fromButton: firstButton, toButton: button, toView: view)
      }
      
      let constraints = [top, bottom, left, right]
      view.addConstraints(constraints)
    }
  }
  
  func addButtonWidthConstraint(fromButton: UIButton, toButton: UIButton, toView view: UIView) {
    // add width constraint between buttons
    let width = NSLayoutConstraint(item: fromButton, attribute: .width, relatedBy: .equal, toItem: toButton, attribute: .width, multiplier: 1, constant: 0)
    width.priority = 800
    view.addConstraint(width)
  }
  
  func addKeyboardViewConstraint(inputView: UIView, rowViews: [UIView]) {
    
    for (index, rowView) in rowViews.enumerated() {
      let left = NSLayoutConstraint(item: rowView, attribute: .left, relatedBy: .equal, toItem: inputView, attribute: .left, multiplier: 1, constant: leftConstraintConstant)
      let right = NSLayoutConstraint(item: rowView, attribute: .right, relatedBy: .equal, toItem: inputView, attribute: .right, multiplier: 1, constant: rightConstraintConstant)
      var top = NSLayoutConstraint()
      var bottom = NSLayoutConstraint()
      
      // if current row is first
      if index == 0 {
        let nextRow = rowViews[index + 1]
        top = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: inputView, attribute: .top, multiplier: 1, constant: 0)
        bottom = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1, constant: 0)
      } else if index == rowViews.count - 1 {
        // if current row is last
        let prevRow = rowViews[index - 1]
        top = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1, constant: 0)
        bottom = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: inputView, attribute: .bottom, multiplier: 1, constant: 0)
        
        // add height constraint between rows
        let firstRow = rowViews[0]
        addRowHeightConstraint(fromRow: firstRow, toRow: rowView, toView: inputView)
        
      } else {
        // if current row is between of other rows
        let nextRow = rowViews[index + 1]
        let prevRow = rowViews[index - 1]
        top = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: prevRow, attribute: .bottom, multiplier: 1, constant: 0)
        bottom = NSLayoutConstraint(item: rowView, attribute: .bottom, relatedBy: .equal, toItem: nextRow, attribute: .top, multiplier: 1, constant: 0)
        
        // add height constraint between rows
        let firstRow = rowViews[0]
        addRowHeightConstraint(fromRow: firstRow, toRow: rowView, toView: inputView)
      }
      
      let constraints = [top, bottom, left, right]
      inputView.addConstraints(constraints)
    }
  }
  
  func addRowHeightConstraint(fromRow: UIView, toRow: UIView, toView view: UIView) {
    // add height constraint between rows
    let height = NSLayoutConstraint(item: fromRow, attribute: .height, relatedBy: .equal, toItem: toRow, attribute: .height, multiplier: 1, constant: 0)
    height.priority = 800
    view.addConstraint(height)
  }
  
  // MARK: - Actions
  
  func actionTapButton(sender: UIButton) {
    let proxy = textDocumentProxy
    if let title = sender.title(for: .normal) {
      switch title {
      case "BS": proxy.deleteBackward()
      case "SPACE": proxy.insertText(" ")
      case "RETURN": proxy.insertText("\n")
      case "KB": advanceToNextInputMode()
      default: proxy.insertText(title)
      }
    }
  }
  
  // MARK: - UITextInputDelegate
  
  override func textWillChange(_ textInput: UITextInput?) {
    // The app is about to change the document's contents. Perform any preparation here.
    print("textWillChange " + textInput.debugDescription)
  }
  
  override func textDidChange(_ textInput: UITextInput?) {
    // The app has just changed the document's contents, the document context has been updated.
    print("textDidChange " + textInput.debugDescription)
  }
}
