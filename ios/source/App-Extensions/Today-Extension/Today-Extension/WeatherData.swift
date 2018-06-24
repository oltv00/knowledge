//
//  WeatherData.swift
//  Today-Extension
//
//  Created by Oleg Tverdokhleb on 22/09/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation

public protocol WeatherDataDelegate {
  func didUpdateWeatherData()
  func didFailureWeatherData()
}

public class WeatherData {
  private let appid = "0b5af5b63086238999f3b22a5d7f4dc5"
  
  public var delegate: WeatherDataDelegate!
  public var temperature: String!
  public var description: String!
  
  public init() {}
  
  public func weatherBy(cityName: String) {
    var cityName = cityName
    
    let city = cityName.components(separatedBy: ",")
    if city.count > 1 {
      cityName = city[0]
    }
    
    var stringURL = "http://api.openweathermap.org/data/2.5/weather"
    let params = "?q=\(cityName)&appid=\(appid)"
    stringURL += params
    if let url = URL(string: stringURL) {
      let request = URLRequest(url: url)
      
      URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
        if error != nil {
          print("Request error = \(error?.localizedDescription)")
        } else {
          do {
            
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
              
              if
                let main = json["main"] as? NSDictionary,
                let temperature = main["temp"] as? Double,
                let wArray = json["weather"] as? NSArray,
                let wDict = wArray[0] as? NSDictionary {
                
                self.temperature = String(format: "%.02f", temperature - 273.15)
                self.description = wDict["description"] as! String
                
                DispatchQueue.main.async {
                  self.delegate.didUpdateWeatherData()
                }
              } else {
                DispatchQueue.main.async {
                  self.delegate.didFailureWeatherData()
                }
              }
            }
          } catch {
            print(error.localizedDescription)
          }
        }
      }).resume()
    }
  }
}
