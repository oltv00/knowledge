//
//  Categories.swift
//  Test-Yandex
//
//  Created by Oleg Tverdokhleb on 08/01/2017.
//  Copyright © 2017 oltv00. All rights reserved.
//

import UIKit

extension UIAlertController {
  static func showAlertInVC(vc: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    vc.present(alert, animated: true, completion: nil)
  }
}
