//
//  PhotoPickerHelper.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 17/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class PhotoPickerHelper: NSObject {
  
  weak var sourceController: UIViewController!
  var pickedImage: (UIImage?) -> Void
  
  init(sourceController: UIViewController, pickedImage: @escaping (UIImage?) -> Void) {
    self.sourceController = sourceController
    self.pickedImage = pickedImage

    super.init()
    showAlert()
  }
  
  func showAlert() {
    let alert = UIAlertController(title: "Pick image from", message: "", preferredStyle: .actionSheet)
    
    if UIImagePickerController.isCameraDeviceAvailable(.rear) {
      let camera = UIAlertAction(title: "Camera", style: .default, handler: { action in
        self.showImagePickerController(sourceType: .camera)
      })
      alert.addAction(camera)
    }
    
    let library = UIAlertAction(title: "Library", style: .default, handler: { action in
      self.showImagePickerController(sourceType: .photoLibrary)
    })
    alert.addAction(library)
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    
    sourceController.present(alert, animated: true, completion: nil)
  }
  
  private func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
    let vc = UIImagePickerController()
    vc.sourceType = sourceType
    vc.delegate = self
    sourceController.present(vc, animated: true, completion: nil)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension PhotoPickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      pickedImage(image)
      picker.dismiss(animated: true, completion: nil)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
