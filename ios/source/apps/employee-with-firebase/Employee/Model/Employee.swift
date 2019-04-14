//
//  Employee.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 30/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
//import Firebase

class Employee {
  let uid: String!
  let name: String!
  let dob: Double!
  let photo: String!
  var isDeveloper: Bool!
  
  init(_ values: [String : Any]) {
    uid = values["uid"] as! String
    name = values["name"] as! String
    dob = values["dateOfBirth"] as! Double
    photo = values["photo"] as! String
    isDeveloper = values["isDeveloper"] as! Bool
  }
  
  init(name: String, dob: Double, photo: String, isDeveloper: Bool) {
    self.uid = ""
    self.name = name
    self.dob = dob
    self.photo = photo
    self.isDeveloper = isDeveloper
  }
}
