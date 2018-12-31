//
//  CentralBank.swift
//  CurrencyExchange
//
//  Created by Oleg Tverdokhleb on 03/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import SWXMLHash


public struct CentralBank {
  public let usdValue: String
  public let eurValue: String
  
  init(xml: XMLIndexer) {
    let usd = try! xml["ValCurs"]["Valute"].withAttr("ID", "R01235")["Value"].element?.text ?? "n/a"
    let eur = try! xml["ValCurs"]["Valute"].withAttr("ID", "R01239")["Value"].element?.text ?? "n/a"
    usdValue = CentralBank.parse(usd)
    eurValue = CentralBank.parse(eur)
  }
  
  static fileprivate func parse(_ value: String) -> String {
    for (idx, val) in value.characters.enumerated() {
      if val == "," {
        var value = value
        let replaceIndex = value.characters.index(value.startIndex, offsetBy: idx)
        value.replaceSubrange(replaceIndex...replaceIndex, with: ".")
        
        if let newValue = Float(value) {
          let result = String(format: "%.2f", newValue)
          return result
        }
      }
    }
    
    return "n/a"
  }
}
