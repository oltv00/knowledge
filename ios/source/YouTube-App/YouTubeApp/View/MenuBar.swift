//
//  MenuBar.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 14/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    return iv
  }()
  
  override var isHighlighted: Bool {
    didSet {
      imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(imageView)
    addConstraintsWithVisualFormat("H:[v0(28)]", views: imageView)
    addConstraintsWithVisualFormat("V:[v0(28)]", views: imageView)
    
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
  }
}

class MenuBar: UIView {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    cv.dataSource = self
    cv.delegate = self
    return cv
  }()
  
  let cellId = "cellId"
  let imageNames = ["home", "trending", "subscriptions", "account"]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    
    addSubview(collectionView)
    addConstraintsWithVisualFormat("H:|[v0]|", views: collectionView)
    addConstraintsWithVisualFormat("V:|[v0]|", views: collectionView)
    
    let indexPathForSelectedItem = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: indexPathForSelectedItem, animated: false, scrollPosition: .init(rawValue: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension MenuBar: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
    let imageName = imageNames[indexPath.row]
    cell.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
    cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
    return cell
  }
}

extension MenuBar: UICollectionViewDelegate {
  
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
