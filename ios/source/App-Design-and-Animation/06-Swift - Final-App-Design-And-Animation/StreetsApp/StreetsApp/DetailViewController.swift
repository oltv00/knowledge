//
//  DetailViewController.swift
//  StreetsApp
//
//  Created by Oleg Tverdokhleb on 04/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  
  let data = getData()
  var index: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    backgroundImageView.image = UIImage(named: data[index]["image"]!)
    avatarImageView.image = UIImage(named: data[index!]["avatar"]!)
    titleLabel.text = data[index!]["title"]
    subTitleLabel.text = data[index!]["subtitle"]
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
}
