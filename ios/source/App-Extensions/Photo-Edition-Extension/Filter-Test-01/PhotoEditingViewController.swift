//
//  PhotoEditingViewController.swift
//  Filter-Test-01
//
//  Created by Oleg Tverdokhleb on 07/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController {
  
  // MARK: - Properties
  
  @IBOutlet weak var imageView: UIImageView!
  
  var input: PHContentEditingInput?
  
  var displayedImage: UIImage?
  var imageOrientation: Int32?
  
  let formatIdentifier = "com.oltv00.Photo-Edition-Extension"
  let formatVersion = "1.0"
  
  var currentFilter = "CISepiaTone"
  
  // MARK: - ViewLifeCycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - PHContentEditingController
  
  func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
    // Inspect the adjustmentData to determine whether your extension can work with past edits.
    // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
    return adjustmentData.formatIdentifier == formatIdentifier && adjustmentData.formatVersion == formatVersion
  }
  
  func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
    // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
    // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
    // If you returned false, the contentEditingInput has past edits "baked in".
    input = contentEditingInput
    
    if input != nil {
      displayedImage = input?.displaySizeImage
      imageOrientation = input?.fullSizeImageOrientation
      imageView.image = displayedImage
    }
  }
  
  func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
    // Update UI to reflect that editing has finished and output is being rendered.
    
    if input == nil {
      self.cancelContentEditing()
      return
    }
    
    // Render and provide output on a background queue.
    DispatchQueue.global().async { [unowned self] in
      // Create editing output from the editing input.
      let output = PHContentEditingOutput(contentEditingInput: self.input!)
      
      let archivedData = NSKeyedArchiver.archivedData(withRootObject: self.currentFilter)
      let adjustmentData = PHAdjustmentData(formatIdentifier: self.formatIdentifier, formatVersion: self.formatVersion, data: archivedData)
      output.adjustmentData = adjustmentData
      
      switch self.input!.mediaType {
      case .image:

        // Get full size image
        if let path = self.input?.fullSizeImageURL?.path {
          
          // Generate rendered JPEG data
          let fullImage = UIImage(contentsOfFile: path)
          let resultImage = self.addFilter(fullImage!, self.imageOrientation)
          let renderedJPEGData = UIImageJPEGRepresentation(resultImage!, 0.9)
          
          // Save JPEG data
          do {
            try renderedJPEGData?.write(to: output.renderedContentURL)
            completionHandler(output)
            
          } catch {
            
            print("finishContentEditing completionHandler try renderedJPEGData?.write failed")
            completionHandler(nil)
          }
          
        } else {
          print("Load Error")
          completionHandler(nil)
        }
        
      case .video:
        // Some do
        break
        
      default: break
      }
    }
  }
  
  var shouldShowCancelConfirmation: Bool {
    // Determines whether a confirmation to discard changes should be shown to the user on cancel.
    // (Typically, this should be "true" if there are any unsaved changes.)
    return false
  }
  
  func cancelContentEditing() {
    // Clean up temporary files, etc.
    // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
  }
  
  // MARK: - Actions
  
  @IBAction func actionSepia(_ sender: UIBarButtonItem) {
    currentFilter = "CISepiaTone"
    
    if displayedImage != nil {
      imageView.image = addFilter(displayedImage!, nil)
    }
  }
  
  @IBAction func actionMono(_ sender: UIBarButtonItem) {
    currentFilter = "CIPhotoEffectMono"
    
    if displayedImage != nil {
      imageView.image = addFilter(displayedImage!, nil)
    }
  }
  
  @IBAction func actionInvert(_ sender: UIBarButtonItem) {
    currentFilter = "CIColorInvert"
    
    if displayedImage != nil {
      imageView.image = addFilter(displayedImage!, nil)
    }
  }
  
  @IBAction func actionBlur(_ sender: UIBarButtonItem) {
    currentFilter = "CIMotionBlur"
    
    if displayedImage != nil {
      imageView.image = addFilter(displayedImage!, nil)
    }
  }
  
  // MARK: - Image Filters
  
  func addFilter(_ inputImage: UIImage, _ orientation: Int32?) -> UIImage? {
    
    var ciImage = CIImage(image: inputImage)
    
    if orientation != nil {
      ciImage = ciImage?.applyingOrientation(orientation!)
    }
    
    let filter = CIFilter(name: currentFilter)
    if let filter = filter {
      filter.setDefaults()
      filter.setValue(ciImage, forKey: "inputImage")
      
      switch currentFilter {
      case "CISepiaTone":
        filter.setValue(0.8, forKey: "inputIntensity")
        
      case "CIMotionBlur":
        filter.setValue(25.0, forKey: "inputRadius")
        filter.setValue(0.0, forKey: "inputAngle")
        
      case "CIPhotoEffectMono": break
      case "CIColorInvert": break
        
      default: break
      }
      
      if let ciFilteredImage = filter.outputImage {
        let context = CIContext(options: [:])
        
        if let cgImage = context.createCGImage(ciFilteredImage, from: ciFilteredImage.extent) {
          let resultImage = UIImage(cgImage: cgImage)
          return resultImage
        }
      }
    }
    
    return nil
  }
  
}
