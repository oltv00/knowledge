//
//  AddNewEmployeeTableViewController.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 28/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class AddNewEmployeeTableViewController: UITableViewController {
  
  // MARK: - @IBOutlets
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dateOfBirthLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var isDeveloperSwitch: UISwitch!
  @IBOutlet weak var isDeveloperLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  // MARK: - Properties
  
  var isSelectDatePicker = false
  var dateOfBirthTimeInterval: TimeInterval = 0
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    datePicker.maximumDate = Date()
    nameTextField.delegate = self
  }
  
  // MARK: - Firebase API
  
  func addNewEmployee() {
    let employee = Employee(
      name: nameTextField.text!,
      dob: dateOfBirthTimeInterval,
      photo: getImage(),
      isDeveloper: isDeveloperSwitch.isOn)
    
    FirebaseAPIManager.sharedManager.addNewEmployee(employee)
  }
  
  // MARK: - Helper funcs
  func reloadDatePickerRow() {
    dateOfBirthLabel.isEnabled = !dateOfBirthLabel.isEnabled
    isSelectDatePicker = !isSelectDatePicker
    tableView.beginUpdates()
    tableView.endUpdates()
  }

  func animationFor(_ label: UILabel) {
    let animation = CATransition()
    animation.type = kCATransitionFade
    label.layer.add(animation, forKey: nil)
  }
  
  func getImage() -> String {
    if let image = photoImageView.image {
      let data = UIImageJPEGRepresentation(image, 0.1)
      let base64String = data?.base64EncodedString(options: .lineLength64Characters)
      return base64String!
    }
    return "NaI"
  }
  
  func showImagePickerAlert() {
    let alert = UIAlertController(title: "", message: "Image from", preferredStyle: .actionSheet)
    let library = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
      self.callImagePicker(.photoLibrary)
    })
    alert.addAction(library)
            
    if UIImagePickerController.isCameraDeviceAvailable(.rear) || UIImagePickerController.isCameraDeviceAvailable(.front) {
      let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
        self.callImagePicker(.camera)
      })
      alert.addAction(camera)
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  func callImagePicker(_ sourceType: UIImagePickerControllerSourceType) {
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.sourceType = sourceType
    present(vc, animated: true, completion: nil)
  }
  
  // MARK: - Action
  
  @IBAction func actionSave(_ sender: UIBarButtonItem) {
    addNewEmployee()
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func actionIsDeveloperSwitch(_ sender: UISwitch) {
    animationFor(isDeveloperLabel)
    let text = sender.isOn ? "Developer" : "Not Developer"
    isDeveloperLabel.text = text
  }
  
  @IBAction func actionDatePicker(_ sender: UIDatePicker) {
    let dateString = stringOfDobFrom(sender.date)
    dateOfBirthLabel.text = dateString
    dateOfBirthTimeInterval = sender.date.timeIntervalSinceNow
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if indexPath.row == 3 {
      let height: CGFloat = isSelectDatePicker ? 216.0 : 0.0
      return height
    }
    
    return super.tableView(tableView, heightForRowAt: indexPath)
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch indexPath.row {
    case 0:
      
      showImagePickerAlert()
      
    case 2:
      
      // unselect name text field
      if nameTextField.canResignFirstResponder {
        nameTextField.resignFirstResponder()
      }
      reloadDatePickerRow()
      
    default: break
    }
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didDeselectRowAt: indexPath)
  }
}

// MARK: - UITextFieldDelegate

extension AddNewEmployeeTableViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - UIImagePickerControllerDelegate

extension AddNewEmployeeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      photoImageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}


