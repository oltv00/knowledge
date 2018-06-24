//
//  NSDate.swift
//  CurrencyExchange
//
//  Created by Oleg Tverdokhleb on 03/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

extension Foundation.Date {
  enum Date { case yesterday, today, tomorrow }
  static func stringFromDate(_ format: Date) -> String {
    
    let date = Foundation.Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/y"
    
    switch format {
    case .yesterday:
      //TODO: complete Yesterday
      return ""
    case .today:
      return formatter.string(from: date)
    case .tomorrow:
      let tomorrowDate = date.addingTimeInterval(86400)
      return formatter.string(from: tomorrowDate)
    }
  }
}
