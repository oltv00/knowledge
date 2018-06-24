//
//  SettingCell.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 23/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
      nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
      iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
    }
  }
  
  var setting: Setting? {
    didSet {
      nameLabel.text = setting?.name
      
      if let imageName = setting?.imageName {
        iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor.darkGray
      }
    }
  }
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(nameLabel)
    addSubview(iconImageView)
    
    addConstraintsWithVisualFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
    addConstraintsWithVisualFormat("V:|[v0]|", views: nameLabel)
    addConstraintsWithVisualFormat("V:[v0(30)]", views: iconImageView)
    
    addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
  }
}
