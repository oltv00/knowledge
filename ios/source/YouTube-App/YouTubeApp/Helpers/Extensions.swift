//
//  Extensions.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 14/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
}

extension UIView {
  func addConstraintsWithVisualFormat(_ format: String, views: UIView...) {
    var viewsDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      view.translatesAutoresizingMaskIntoConstraints = false
      viewsDictionary[key] = view
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
  }
}

let imageCache = NSCache<AnyObject, UIImage>()

class CustomImageView: UIImageView {
  
  var imageUrlString: String?
  
  func loadImageUsingUrlString(_ urlString: String) {
    
    imageUrlString = urlString
    
    image = nil
    
    if let image = imageCache.object(forKey: NSString(string: urlString)) {
      self.image = image
      return
    }
    
    if let url = URL(string: urlString) {
      URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if error != nil {
          print("\(error)")
          return
        }
        
        DispatchQueue.main.async {
          let imageToCache = UIImage(data: data!)
          
          if self.imageUrlString == urlString {
            self.image = imageToCache
          }
          
          imageCache.setObject(imageToCache!, forKey: NSString(string: urlString))
        }
      }).resume()
    }
  }
}
