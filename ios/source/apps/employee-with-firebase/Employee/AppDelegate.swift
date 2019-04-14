//
//  AppDelegate.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 24/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    FIRApp.configure()
    //Fabric.with([Twitter.self])
    
    return true
  }
  
  @available(iOS 9.0, *)
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
    return self.handleOpenUrl(url, sourceApplication: sourceApplication)
  }
  
  @available(iOS 8.0, *)
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return self.handleOpenUrl(url, sourceApplication: sourceApplication)
  }
  
  
  func handleOpenUrl(_ url: URL, sourceApplication: String?) -> Bool {
    if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
      return true
    }
    // other URL handling goes here.
    return false
  }

}

