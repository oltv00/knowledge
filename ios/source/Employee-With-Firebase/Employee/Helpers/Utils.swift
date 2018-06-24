//
//  Utils.swift
//  Employee
//
//  Created by Oleg Tverdokhleb on 28/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

func stringOfDobFrom(_ date: Date) -> String {
  let df = DateFormatter()
  df.dateStyle = .medium
  return df.string(from: date)
}

func stringOfDobFrom(_ timeInterval: TimeInterval) -> String {
  let date = Date(timeIntervalSinceNow: timeInterval)
  let string = stringOfDobFrom(date)
  return string
}

func photoImageFrom(_ base64: String) -> UIImage {
  let decodedData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
  let image = UIImage(data: decodedData!)
  return image!
}
