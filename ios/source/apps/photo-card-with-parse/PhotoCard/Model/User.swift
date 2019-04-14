//
//  User.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {
  
  @NSManaged var cardIds: [String]!
  @NSManaged var profileImageFile: PFFile
 
  private static var __once: () = {
    registerSubclass()
  }()
  
//  override class func initialize() {
//    _ = User.__once
//  }
  
  func joinCard(cardId: String) {
    
    if self.cardIds == nil {
      self.cardIds = [cardId]
    } else {
      self.cardIds.insert(cardId, at: 0)
    }
    
    self.saveInBackground { (success, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else {
        print("User joinCard success")
      }
    }
  }
  
  
  
}
