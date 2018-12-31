//
//  ViewController.swift
//  Test-OneTRAK
//
//  Created by Oleg Tverdokhleb on 07/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlents
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var inputTextField: UITextField!
  
  // MARK: - Properties
  
  let MaxInputNumber = 1_000_000_000
  var counter = 0
  var result = 0
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reset()
  }
  
  func updateUI() {
    inputTextField.text = ""
    resultLabel.text = "\(result)"
    countLabel.text = "\(counter)"
  }
  
  func reset() {
    counter = 0
    result = 0
    inputTextField.becomeFirstResponder()
    inputTextField.text = ""
    countLabel.text = "0"
    resultLabel.text = "Результат"
  }
  
  // MARK: - Helper funcs
  
  func calc() -> Int {
    
    guard let input = Int(inputTextField.text!) else {
      showAlert(title: "Ошибка", message: "Введите число")
      return result
    }
    
    if input > MaxInputNumber {
      showAlert(title: "Очень большое число", message: "Введите число поменьше, или воспользуйтесь калькулятором.")
      return result
    }
    
    counter += 1
    return square(input)
  }
  
  func square(_ input: Int) -> Int {
    var result = 0
    for _ in 0..<input {
      result += input
    }
    return result
  }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Action
  
  @IBAction func actionCalculate(_ sender: UIButton) {
    result = calc()
    updateUI()
  }
  
  @IBAction func actionReset(_ sender: UIButton) {
    reset()
  }
}

class MyCustomTextField: UITextField {
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
    if action == #selector(paste(_:)) || action == #selector(copy(_:)) {
      return false
    }
    
    return super.canPerformAction(action, withSender: sender)
  }
}

extension ViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let chs = CharacterSet.decimalDigits.inverted
    if string.components(separatedBy: chs).count > 1 {
      return false
    }
    
    return true
  }
}
