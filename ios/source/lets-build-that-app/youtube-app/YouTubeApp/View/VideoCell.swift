//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 14/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class VideCell: BaseCell {

  var video: Video? {
    didSet {
      titleLabel.text = video?.title
      
      setupThumbnailImage()
      setupProfileImage()
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
        subtitleTextView.text = subtitleText
      }
      
      //measure title text
      if let title = video?.title {
        let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
        if estimatedRect.size.height > 20 {
          titleLabelHeightConstraint?.constant = 44
        } else {
          titleLabelHeightConstraint?.constant = 20
        }
      }
      
    }
  }
  
  func setupThumbnailImage() {
    if let thumbnailImageUrl = video?.thumbnailImageUrl {
      thumbnailImageView.loadImageUsingUrlString(thumbnailImageUrl)
    }
  }
  
  func setupProfileImage() {
    if let profileImageUrl = video?.channel?.profileImageUrl {
      userProfileImageView.loadImageUsingUrlString(profileImageUrl)
    }
  }
  
  let thumbnailImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "taylor-swift-blank-space")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let userProfileImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "taylor-swift-profile")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Taylor Swift - Blank Space"
    label.numberOfLines = 2
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "TaylorSwiftVEVO - 1,654,356,234 views - 2 years ago"
    textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
    textView.textColor = UIColor.lightGray
    return textView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    return view
  }()
  
  var titleLabelHeightConstraint: NSLayoutConstraint?
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(thumbnailImageView)
    addSubview(separatorView)
    addSubview(userProfileImageView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    addConstraintsWithVisualFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
    addConstraintsWithVisualFormat("H:|[v0]|", views: separatorView)
    addConstraintsWithVisualFormat("H:|-16-[v0(44)]", views: userProfileImageView)
    
    //vertical constraints
    addConstraintsWithVisualFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
    
    //titleLabel
    //top constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    //left constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    //right constraint
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    //height constraint
    titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
    addConstraint(titleLabelHeightConstraint!)
    
    //subtitleTextView
    //top constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    //left constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    //right constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    //height constraint
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }

}




