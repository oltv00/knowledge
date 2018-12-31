//
//  ServerManagerAPI.swift
//  test-yandex
//
//  Created by Oleg Tverdokhleb on 29/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

typealias JSON = Array<[String : AnyObject]>

enum RequestState {
  case responseSuccess
  case serverError
  case noInternetConnection
}

class ServerManagerAPI {
  
  static let shared: ServerManagerAPI = {
    return ServerManagerAPI()
  }()
  
  private let context = CoreDataStack.shared.persistentContainer.viewContext
  
  func categoriesList(completion: @escaping (_ state: RequestState) -> Void) {
    guard let url = URL(string: kServerAPI.categoriesList) else {
      return
    }
    let task = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
      
      if error != nil {
        // response with no internet connection
        completion(.noInternetConnection)
      } else {
        
        do {
          guard let data = data else {
            // response with server error
            // check server response
            completion(.serverError)
            return
          }
          let responseObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSON
          
          for item in responseObject {
            if
              let title = item["title"] as? String,
              let subs = item["subs"] as? JSON {
              
              // initialize objects with current moc
              let category = Category(context: self.context)
              category.title = title

              for sub in subs {
                if
                  let id = sub["id"] as? Int,
                  let title = sub["title"] as? String {
                  
                  // initialize objects with current moc
                  let subCategory = SubCategory(context: self.context)
                  subCategory.id = NSDecimalNumber(value: id)
                  subCategory.title = title
                  subCategory.category = category
                }
              }
            }
          }
          
          CoreDataStack.shared.saveContext()
          completion(.responseSuccess)
          
        } catch {
          // response with server error
          // check server response
          print("JSONSerialization.jsonObject faild \(error.localizedDescription)")
          completion(.serverError)
        }
      }
    }
    
    task.resume()
  }
}
