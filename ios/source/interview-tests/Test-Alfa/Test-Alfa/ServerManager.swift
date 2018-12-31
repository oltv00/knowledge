//
//  ServerManager.swift
//  Test-Alfa
//
//  Created by Oleg Tverdokhleb on 15/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import RealmSwift

class ServerManager {
  static let shared: ServerManager = {
    let instance = ServerManager()
    return instance
  }()
  
  private let realm = try! Realm()
  
  func getNews(completion: @escaping () -> Void) {
    
    print("ServerManager.shared.getNews begin")
    
    let url = URL(string: "https://alfabank.ru/_/rss/_rss.html?subtype=1&category=2&city=21")!
    
    Alamofire.request(url, method: .get)
      .responseData { (response) in
        if let data = response.result.value {
          let xml = SWXMLHash.parse(data)
          
          for (i, v) in xml["rss"]["channel"]["item"].all.enumerated() {
            let title = v["title"].element?.text
            let link = v["guid"].element?.text
            let date = v["pubDate"].element?.text
            let id = NSNumber(value: i)
            
            try! self.realm.write {
              
              let article = Article()
              article.id = id
              article.title = title
              article.link = link
              article.date = date
              
              self.realm.add(article, update: true)
            }
          }
          
          print("ServerManager.shared.getNews completion")
          completion()
        }
    }
  }
  
}
