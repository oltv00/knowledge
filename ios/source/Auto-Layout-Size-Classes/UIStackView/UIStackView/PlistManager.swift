//
//  PlistManager.swift
//  UIStackView
//
//  Created by Oleg Tverdokhleb on 20/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

func getPlist(forName name: String) -> NSArray? {
  let source = Bundle.main.path(forResource: name, ofType: "plist")
  if let source = source {
    return NSArray(contentsOfFile: source)
  }
  return nil
}
