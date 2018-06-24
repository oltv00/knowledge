//
//  SourceViewController.swift
//  Test-Alfa
//
//  Created by Oleg Tverdokhleb on 16/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import SafariServices

class SourceViewController: UIViewController {

  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Action
  
  @IBAction func actionWeb(_ sender: UIButton) {
    let url = URL(string: "https://oltv00.github.io")
    let sf = SFSafariViewController.init(url: url!)
    show(sf, sender: nil)
  }
  
  @IBAction func actionGit(_ sender: UIButton) {
    let url = URL(string: "https://github.com/oltv00")
    let sf = SFSafariViewController.init(url: url!)
    show(sf, sender: nil)
  }
  
  @IBAction func actionIn(_ sender: UIButton) {
    let url = URL(string: "https://ru.linkedin.com/in/oltv00")
    let sf = SFSafariViewController.init(url: url!)
    show(sf, sender: nil)
  }
}
