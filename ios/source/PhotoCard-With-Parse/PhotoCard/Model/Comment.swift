//
//  Comment.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Parse

class Comment: PFObject, PFSubclassing {
  
  @NSManaged var user: PFUser
  @NSManaged var commentText: String!
  @NSManaged var numberOfLikes: Int
  @NSManaged var cardId: String!
  @NSManaged var likeUserIds: [String]!
  
  private static var __once: () = {
    registerSubclass()
  }()
  
//  override class func initialize() {
//    _ = Comment.__once
//  }
  
  public static func parseClassName() -> String {
    return "Comment"
  }
  
  override init() {
    super.init()
  }
  
  init(user: PFUser, commentText: String, numberOfLikes: Int, cardId: String) {
    super.init()
    self.user = user
    self.commentText = commentText
    self.numberOfLikes = numberOfLikes
    self.cardId = cardId
    self.likeUserIds = [String]()
  }
  
  func like() {
    let userId = User.current()?.objectId
    if let index = likeUserIds.index(of: userId!) {
      numberOfLikes -= 1
      likeUserIds.remove(at: index)
    } else {
      numberOfLikes += 1
      likeUserIds.insert(userId!, at: 0)
    }
    saveObject()
  }
  
  func saveObject() {
    self.saveInBackground(block: { (success, error) in
      if error != nil {
        print(error!.localizedDescription)
      } else { print("\(self.user.username) like success") }
    })
  }
}
