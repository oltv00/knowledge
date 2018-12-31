//
//  Video.swift
//  YouTubeApp
//
//  Created by Oleg Tverdokhleb on 15/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import Foundation

class Video: NSObject {
  var thumbnailImageUrl: String?
  var title: String?
  var numberOfViews: NSNumber?
  var uploadDate: NSDate?
  
  var channel: Channel?
}

class Channel: NSObject {
  var name: String?
  var profileImageUrl: String?
}
