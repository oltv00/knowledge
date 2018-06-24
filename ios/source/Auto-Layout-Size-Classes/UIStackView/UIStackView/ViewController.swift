//
//  ViewController.swift
//  UIStackView
//
//  Created by Oleg Tverdokhleb on 18/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var verticalStackView: UIStackView!
  @IBOutlet weak var horizontalStackView: UIStackView!
  @IBOutlet weak var durationLabel: UILabel!
  
  // MARK: - Properties
  
  var animateDuration: TimeInterval = 0.0
  let urls = getPlist(forName: "URLs")
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Actions
  
  @IBAction func actionAddButton(_ sender: UIButton) {
    let button = UIButton(type: .system)
    let newIndex = verticalStackView.arrangedSubviews.count - 1
    button.setTitle("New #\(newIndex)", for: .normal)
    button.setTitleColor(randomColor(), for: .normal)
    button.backgroundColor = randomColor()
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
    button.isHidden = true
    button.alpha = 0.0
    verticalStackView.insertArrangedSubview(button, at: 1)
    
    UIView.animate(withDuration: self.animateDuration, animations: {
      button.isHidden = false
    }) {(finished) in
      UIView.animate(withDuration: self.animateDuration, animations: {
        button.alpha = 1.0
      })
    }
  }
  
  @IBAction func actionRemoveButton(_ sender: UIButton) {
    let endIndex = verticalStackView.arrangedSubviews.endIndex
    let removeButton = verticalStackView.arrangedSubviews[endIndex - 2] as! UIButton
    if removeButton !== sender,
      removeButton.titleLabel?.text != "Add Button" {
      UIView.animate(withDuration: self.animateDuration, animations: {
        removeButton.alpha = 0.0
        }) {(finished) in
          UIView.animate(withDuration: self.animateDuration, animations: {
            removeButton.isHidden = true
          }) {(finished) in
            self.verticalStackView.removeArrangedSubview(removeButton)
            removeButton.removeFromSuperview()
          }
      }
    }
  }
  
  @IBAction func actionAddImage(_ sender: UIButton) {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    horizontalStackView.addArrangedSubview(imageView)
    UIView.animate(withDuration: self.animateDuration) { 
     self.horizontalStackView.layoutIfNeeded()
    }
    
    DispatchQueue.global(qos: .background).async {
      if let urls = self.urls {
        let sUrl = urls[Int(arc4random_uniform(UInt32(urls.count)))] as! String
        let url = URL(string: sUrl)
        if let data = self.getData(url: url!) {
          DispatchQueue.main.async {
            imageView.image = UIImage(data: data)
          }
        }
      }
    }
  }
  
  @IBAction func actionRemoveImage(_ sender: UIButton) {
    let lastImage = horizontalStackView.arrangedSubviews.last
    if let lastImage = lastImage {
      horizontalStackView.removeArrangedSubview(lastImage)
      lastImage.removeFromSuperview()
      UIView.animate(withDuration: self.animateDuration, animations: { 
        self.horizontalStackView.layoutIfNeeded()
      })
    }
  }
  
  @IBAction func actionDurationSlider(_ sender: UISlider) {
    durationLabel.text = "\(sender.value)"
    animateDuration = TimeInterval(sender.value)
  }
  
  // MARK: - Helper funcs
  
  func randomColor() -> UIColor {
    let r: CGFloat = CGFloat(arc4random_uniform(256)) / 255
    let g: CGFloat = CGFloat(arc4random_uniform(256)) / 255
    let b: CGFloat = CGFloat(arc4random_uniform(256)) / 255
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }
  
  func getData(url: URL) -> Data? {
    do { return try Data(contentsOf: url) }
    catch { print(error); return nil }
  }
}

