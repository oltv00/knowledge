//
//  File.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Parse

class Card: PFObject, PFSubclassing {
  
  @NSManaged var title: String!
  @NSManaged var descr: String!
  @NSManaged var comments: Int
  @NSManaged var image: PFFile
  
  private static var __once: () = {
    registerSubclass()
  }()
  
//  override class func initialize() {
//    _ = Card.__once
//  }
  
  public static func parseClassName() -> String {
    return "Card"
  }
  
  override init() {
    super.init()
  }
  
  init(title: String, description: String, image: PFFile, comments: Int) {
    super.init()
    self.title = title
    self.descr = description
    self.image = image
    self.comments = comments
  }
  
  func incrementNumberOfComment() {
    comments += 1
    self.saveInBackground()
  }
}
