//
//  FirebaseAPIManager.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 30/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAPIManager {
  static let sharedManager: FirebaseAPIManager = {
    let instance = FirebaseAPIManager()
    return instance
  }()
  
  var ref: FIRDatabaseReference!
  
  private func initRef() -> FIRDatabaseReference {
    return FIRDatabase.database().reference()
  }
  
  private func initProfileRef() -> FIRDatabaseReference {
    return FIRDatabase.database().reference().child("profiles")
  }
  
  // MARK: - GET
  
  func getEmployeeProfiles(success: @escaping ([Employee]) -> Void) {
    var employees = [Employee]()
    ref = initProfileRef()
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      if let values = snapshot.value as? [String : Dictionary<String, Any>] {
        for (_, value) in values {
          let employee = Employee(value)
          employees.append(employee)
        }
      }
      success(employees)
    })
  }
  
  // MARK: - POST
  
  func addNewEmployee(_ employee: Employee) {
    ref = initProfileRef()
    let uid = ref.childByAutoId().key
    let values = [
      "uid" : uid,
      "name" : employee.name,
      "dateOfBirth" : employee.dob,
      "photo" : employee.photo,
      "isDeveloper" : employee.isDeveloper] as [String : Any
    ]
    ref.child(uid).setValue(values)
  }
  
  func removeValue(_ uid: String, failure: @escaping (_ error: Error) -> Void) {
    ref = initProfileRef().child(uid)
    ref.removeValue { (error, ref) in
      if let error = error {
        failure(error)
      }
    }
  }
  
  func updateValue(uid: String, row: String, value: Any) {
    ref = initProfileRef().child(uid)
    ref.updateChildValues([row : value])
  }
}

