//
//  DetailedViewController.swift
//  Test-Alfa
//
//  Created by Oleg Tverdokhleb on 14/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Social

class DetailedArticleViewController: UIViewController {
  
  // MARK: - @IBOutlet
  
  @IBOutlet weak var webView: UIWebView!
  
  // MARK: - instance variable
  
  var url: URL!
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let request = URLRequest(url: self.url)
    webView.loadRequest(request)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Action
  
  @IBAction func actionShare(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Share options", message: nil, preferredStyle: .actionSheet)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    let twitter = UIAlertAction(title: "Twitter", style: .default) { (action) in
      self.twitterShare()
    }
    
    let facebook = UIAlertAction(title: "Facebook", style: .default) { (action) in
      self.facebookShare()
    }
    
    alert.addAction(twitter)
    alert.addAction(facebook)
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Share
  
  func twitterShare() {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
      let twitVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitVC?.add(url)
      present(twitVC!, animated: true, completion: nil)
    } else {
      UIAlertController.showAlertInVC(vc: self, title: "Ошибка", message: "Войдите в свой Twitter аккаунт")
    }
  }
  
  func facebookShare() {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
      let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
      facebookVC?.add(url)
      present(facebookVC!, animated: true, completion: nil)
    } else {
      UIAlertController.showAlertInVC(vc: self, title: "Ошибка", message: "Войдите в свой Facebook аккаунт")
    }
  }
}

// MARK: - Extension

extension UIAlertController {
  static func showAlertInVC(vc: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    vc.present(alert, animated: true, completion: nil)
  }
}


