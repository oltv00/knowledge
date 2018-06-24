//
//  MoscowExchange.swift
//  CurrencyExchange
//
//  Created by Oleg Tverdokhleb on 03/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

public struct MoscowExchange {
  public var last: String
  public var max: String
  public var min: String
  public var prcnt: String
  
  init(values: NSDictionary) {
    let lastFloat = values["LAST"] as! NSNumber.FloatLiteralType
    let maxFloat = values["HIGH"] as! NSNumber.FloatLiteralType
    let minFloat = values["LOW"] as! NSNumber.FloatLiteralType
    let prcntFloat = values["LASTCHANGEPRCNT"] as! NSNumber.FloatLiteralType
    
    last = String(format: "%.2f", lastFloat)
    max = String(format: "%.2f", maxFloat)
    min = String(format: "%.2f", minFloat)
    prcnt = String(format: "%.2f", prcntFloat)
  }
}
