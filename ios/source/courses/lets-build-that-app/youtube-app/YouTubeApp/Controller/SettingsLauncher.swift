//
//  SettingsLauncher.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 18/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

class Setting: NSObject {
  let name: String
  let imageName: String
  
  init(_ name: String, _ imageName: String) {
    self.name = name
    self.imageName = imageName
  }
}

class SettingsLauncher: NSObject {
  
  override init() {
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  let cellId = "CellId"
  let cellHeight: CGFloat = 44
  
  let blackView = UIView()
  
  weak var homeController: HomeController?
  
  let settings: [Setting] = {
    return [
      Setting("Settings", "settings"),
      Setting("Terms & privacy policy", "privacy"),
      Setting("Send Feedback", "feedback"),
      Setting("Help", "help"),
      Setting("Switch Account", "switch_account"),
      Setting("Cancel", "cancel")
    ]
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = UIColor.white
    return cv
  }()
  
  func showSettings() {
    if let window = UIApplication.shared.keyWindow {
      blackView.backgroundColor = UIColor.black
      blackView.frame = window.frame
      blackView.alpha = 0
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height = CGFloat(settings.count) * cellHeight
      
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
        self.blackView.alpha = 0.5
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height - height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      })
    }
  }
  
  func handleDismiss(_ setting: Setting) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.blackView.alpha = 0
      
      if let window = UIApplication.shared.keyWindow {
        
        self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }
    }) { (isFinished) in
      self.blackView.removeFromSuperview()
      
      if setting.name != "" && setting.name != "Cancel" {
        self.homeController?.showControllerForSetting(setting)
      }
    }
  }
  
}

extension SettingsLauncher: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return settings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
    
    cell.setting = settings[indexPath.item]
    
    return cell
  }
}

extension SettingsLauncher: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let setting = self.settings[indexPath.item]
    handleDismiss(setting)
  }
}

extension SettingsLauncher: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}













