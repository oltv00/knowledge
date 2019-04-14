//
//  ViewController.swift
//  Photo-Edition-Extension
//
//  Created by Oleg Tverdokhleb on 26/10/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - Properties
  
  @IBOutlet weak var imageView: UIImageView!
  
  var currentFilter = ""
  var originalImage: UIImage?
  
  let filters = ["CISepiaTone", "CIMotionBlur", "CIPhotoEffectMono", "CIColorInvert"]
  
  // MARK: - ViewLifeCycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Action
  
  @IBAction func actionAddImage(_ sender: UIButton) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
    self.present(picker, animated: true, completion: nil)
  }
  
  @IBAction func actionAddRandomFilter(_ sender: UIButton) {
    currentFilter = filters[Int(arc4random_uniform(4))]
    if let inputImage = originalImage {
      if let resultImage = addFilter(inputImage, nil) {
        imageView.image = resultImage
      }
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
  
  // MARK: - UIImagePickerControllerDelegate
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
      originalImage = image
      imageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
}
