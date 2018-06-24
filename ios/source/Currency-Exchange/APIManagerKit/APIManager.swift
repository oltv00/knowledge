//
//  APIManager.swift
//  CurrencyExchange
//
//  Created by Oleg Tverdokhleb on 06/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

// MARK: - Moscow Exchange

public class APIManager {
  
  public static let shared = {
    return APIManager()
  }()
  
  public func getMEUSD(_ completion: @escaping (MoscowExchange) -> Void) {
    let usdURL = "http://www.micex.ru/issrpc/marketdata/currency/selt/daily/short/result.json?boardid=CETS&secid=USD000UTSTOM&lang=ru"
    getMECurrencyByURL(usdURL) { (USD) in
      print("getMEUSD")
      completion(USD)
    }
  }
  
  public func getMEEUR(_ completion: @escaping (MoscowExchange) -> Void) {
    let eurURL = "http://www.micex.ru/issrpc/marketdata/currency/selt/daily/short/result.json?boardid=CETS&secid=EUR_RUB__TOM&lang=ru"
    getMECurrencyByURL(eurURL) { (EUR) in
      print("getMEEUR")
      completion(EUR)
    }
  }
  
  public func getMECurrencyByURL(_ url: String, completion: @escaping (MoscowExchange) -> Void) {
    Alamofire.request(url, method: .get)
      .responseJSON { (response) in
        
        if let json = response.result.value {
          let json = json as! [AnyObject]
          if let values = json.last as? NSDictionary {
            let currency = MoscowExchange(values: values)
            completion(currency)
          }
        }
    }
  }
  
  // MARK: - Central Bank
  
  let CentralBankURL = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
  
  public func getTodayCentralBankCurrency(_ completion: @escaping (_ currency:CentralBank?, _ error:NSError?) -> Void) {
    print("getTodayCentralBankCurrency")
    
    var getURL = CentralBankURL
    let today = Date.stringFromDate(Date.Date.today)
    getURL.append(today)
    print("Today = \(today)")
    
    getCentralBankCurrency(getURL) { (currency, error) in
      completion(currency, error)
    }
  }
  
  public func getTomorrowCentralBankCurrency(_ completion: @escaping (_ currency:CentralBank?, _ error:NSError?) -> Void) {
    print("getTomorrowCentralBankCurrency")
    
    var getURL = CentralBankURL
    let tomorrow = Date.stringFromDate(Date.Date.tomorrow)
    getURL.append(tomorrow)
    print("Tomorrow = \(tomorrow)")
    
    getCentralBankCurrency(getURL) { (currency, error) in
      completion(currency, error)
    }
  }
  
  public func getCentralBankCurrency (_ url: String,
                                       completion: @escaping (_ currency:CentralBank?, _ error:NSError?) -> Void)
  {
    Alamofire.request(url, method: .get)
      .responseData { (data) in
        if data.result.error != nil {
          // DEBUG
          print("getCentralBankCurrency error = \(data.result.error)")
          completion(nil, data.result.error as NSError?)
          
        } else {
          if let data = data.result.value {
            let xml = SWXMLHash.parse(data)
            let currencies = CentralBank(xml: xml)
            completion(currencies, nil)
          }
        }
    }
  }
  
}
