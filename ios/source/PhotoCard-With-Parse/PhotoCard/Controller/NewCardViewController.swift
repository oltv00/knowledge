//
//  NewCardViewController.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 17/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Parse

class NewCardViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var getImageButton: UIButton!
  
  var photoPicker: PhotoPickerHelper?
  var cardImage: UIImage!
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.becomeFirstResponder()
    titleTextField.delegate = self
    descriptionTextView.delegate = self
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - API
  
  func createNewCard() {
    
    let card = Card(title: titleTextField.text!, description: descriptionTextView.text, image: createFileFromImage(image: cardImage), comments: 0)
    
    card.saveInBackground(block: { (success, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else {
        
        print("card.saveInBackground")
        
        // update the current user's cardIds
        let currentUser = User.current()!
        currentUser.joinCard(cardId: card.objectId!)
        
        currentUser.saveInBackground(block: { (success, error) in
          if error != nil {
            print(error!.localizedDescription)
          } else {
            
            print("currentUser.saveInBackground")
            
          }
        })
      }
    })
    
  }
  
  // MARK: - Action
  
  @IBAction func actionCancel(_ sender: UIBarButtonItem) {
    hideKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func actionDone(_ sender: UIBarButtonItem) {
    createNewCard()
    hideKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func actionGetImage(_ sender: UIButton) {
    photoPicker = PhotoPickerHelper(sourceController: self, pickedImage: { (image) in
      self.cardImage = image
      self.imageView.image = image
    })
  }
  
  // MARK: - Helper methods
  
  func hideKeyboard() {
    if titleTextField.isFirstResponder {
      titleTextField.resignFirstResponder()
    } else if descriptionTextView.isFirstResponder {
      descriptionTextView.resignFirstResponder()
    }
  }
  
  func createFileFromImage(image: UIImage) -> PFFile! {
    let ratio = image.size.width / image.size.height
    let newHeight: CGFloat = 480.0
    let resizedImage = resizeImage(originalImage: image, toWidth: newHeight * ratio, andHeight: newHeight)
    let imageData = UIImageJPEGRepresentation(resizedImage, 0.8)
    return PFFile(name: "image.jpg", data: imageData!)
  }
  
  func resizeImage(originalImage: UIImage, toWidth width: CGFloat, andHeight height: CGFloat) -> UIImage {
    
    let newSize = CGSize(width: width, height: height)
    let newRect = CGRect(x: 0, y: 0, width: width, height: height)
    
    UIGraphicsBeginImageContext(newSize)
    originalImage.draw(in: newRect)
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return resizedImage
  }
}

// MARK: - UITextFieldDelegate
extension NewCardViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if !textField.text!.isEmpty {
      descriptionTextView.becomeFirstResponder()
    } else if titleTextField.text!.isEmpty {
      textField.resignFirstResponder()
    }
    return true
  }
}

// MARK: - UITextViewDelegate
extension NewCardViewController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    textView.text = ""
    return true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Description"
    }
  }
}
