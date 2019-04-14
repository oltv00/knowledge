//
//  NewCommentViewController.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 15/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var todayLabel: UILabel!
  @IBOutlet weak var commentTextView: UITextView!
  
  // MARK: - Life view cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commentTextViewSetup()
    addNotification()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func commentTextViewSetup() {
    commentTextView.becomeFirstResponder()
    commentTextView.text = ""
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Notification
  
  func addNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
  }
  
  func keyboardWillHide(_ notification: Notification) {
    commentTextView.contentInset = UIEdgeInsets.zero
    commentTextView.scrollIndicatorInsets = UIEdgeInsets.zero
  }
  
  func keyboardWillShow(_ notification: Notification) {
    if let userInfo = notification.userInfo {
      let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
      commentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
      commentTextView.scrollIndicatorInsets = commentTextView.contentInset
    }
  }
  
  // MARK: - Action
  
  @IBAction func actionCancel(_ sender: UIBarButtonItem) {
    commentTextView.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func actionDone(_ sender: UIBarButtonItem) {
    commentTextView.resignFirstResponder()
  }
  
}
