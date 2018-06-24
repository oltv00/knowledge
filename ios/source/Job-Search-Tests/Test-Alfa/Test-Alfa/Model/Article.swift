//
//  Article.swift
//  Test-Alfa
//
//  Created by Oleg Tverdokhleb on 15/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
  dynamic var id: NSNumber? = NSNumber(value: 0)
  dynamic var title: String?
  dynamic var link: String?
  dynamic var date: String?
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
