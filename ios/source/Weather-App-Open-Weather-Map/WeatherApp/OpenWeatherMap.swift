//
//  OpenWeatherMap.swift
//  WeatherApp
//
//  Created by Oleg Tverdokhleb on 11/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

protocol OpenWeatherMapDelegate {
  func didUpdateWeatherInfo()
  func didFailureToLoadInfo()
}

class Forecast {
  var date: String?
  var icon: UIImage?
  var temp: Double?
}

class OpenWeatherMap {
  
  static let shared: OpenWeatherMap = {
    let instance = OpenWeatherMap()
    return instance
  }()
  
  // MARK: - Properties
  
  typealias JSON = [String: AnyObject]
  
  var nameCity: String?
  var country: String?
  var temp: Double?
  var description: String?
  var currentTime: String?
  var icon: UIImage?
  var windSpeed: Double?
  var humidity: Int?
  var forecasts = [Forecast]()
  
  var delegate: OpenWeatherMapDelegate!
  
  let currentURL = "http://api.openweathermap.org/data/2.5/weather"
  let forecastURL = "http://api.openweathermap.org/data/2.5/forecast"
  
  // MARK: - Public API funcs
  
  func currentWeatherFor(_ city: String) {
    let params = [
      "q"     : city,
      "appid" : "0b5af5b63086238999f3b22a5d7f4dc5"
    ]
    setCurrentRequest(params as JSON)
  }
  
  func currentWeatherFor(_ location: CLLocationCoordinate2D) {
    let params = paramsForLocation(location)
    setCurrentRequest(params as JSON)
  }
  
  func forecastWeatherFor(_ location: CLLocationCoordinate2D) {
    let params = paramsForLocation(location)
    setForecastRequest(params as JSON)
  }
  
  // MARK: - Private API funcs
  
  private func setForecastRequest(_ params: JSON) {
    Alamofire.request(forecastURL, method: .get, parameters: params)
      .responseJSON { (json) in
        if json.result.error != nil {
          self.delegate.didFailureToLoadInfo()
        } else {
          
          //print(json.result.value)
          
          let json = json.result.value as! JSON
          if
            let city = json["city"] as? JSON,
            let name = city["name"] as? String,
            let country = city["country"] as? String,
            let list = json["list"] as? NSArray {
            
            self.nameCity = name
            self.country = country
            
            //let listCount = list.count > 4 ? 4 : list.count
            let listCount = list.count
            for idx in 0..<listCount {
              if
                let json = list[idx] as? JSON,
                let date = json["dt"] as? Double,
                let main = json["main"] as? JSON,
                let temp = main["temp"] as? Double,
                let wArray = json["weather"] as? NSArray,
                let wDict = wArray[0] as? NSDictionary,
                let iconType = wDict["icon"] as? String {
                
                let forecast = Forecast()
                forecast.date = self.stringFromTimeInterval(date, format: "MM/dd EEEE HH:mm")
                forecast.temp = self.tempByCountry(country, temp: temp)
                forecast.icon = self.iconByType(iconType)
                self.forecasts.append(forecast)
              }
            }
          }
          
          DispatchQueue.main.async(execute: { 
            self.delegate.didUpdateWeatherInfo()
          })
        }
    }
  }
  
  private func setCurrentRequest(_ params: JSON) {
    Alamofire.request(currentURL, method: .get, parameters: params)
      .responseJSON { (json) in
        if json.result.error != nil {
          self.delegate.didFailureToLoadInfo()
        } else {
          
          //print(json.result.value)
          
          let json = json.result.value as! NSDictionary
          if
            let name = json["name"] as? String,
            let main = json["main"] as? NSDictionary,
            let temp = main["temp"] as? Double,
            let sys = json["sys"] as? NSDictionary,
            let country = sys["country"] as? String,
            let wArray = json["weather"] as? NSArray,
            let wDict = wArray[0] as? NSDictionary,
            let description = wDict["description"] as? String,
            let date = json["dt"] as? Double,
            let iconType = wDict["icon"] as? String,
            let wind = json["wind"] as? NSDictionary,
            let windSpeed = wind["speed"] as? Double,
            let humidity = main["humidity"] as? Int {
            
            self.nameCity = name
            self.country = country
            self.temp = self.tempByCountry(country, temp: temp)
            self.description = description.capitalized
            self.currentTime = self.stringFromTimeInterval(date, format: "HH:mm")
            self.icon = self.iconByType(iconType)
            self.windSpeed = windSpeed
            self.humidity = humidity
          }
          
          DispatchQueue.main.async(execute: {
            self.delegate.didUpdateWeatherInfo()
          })
        }
    }
  }
  
  private func paramsForLocation(_ location: CLLocationCoordinate2D) -> JSON {
    let params = [
      "lat"   : "\(location.latitude)",
      "lon"   : "\(location.longitude)",
      "appid" : "0b5af5b63086238999f3b22a5d7f4dc5"
    ]
    return params as JSON
  }
  
  // MARK: - Helper funcs
  
  private func stringFromTimeInterval(_ timeInterval: TimeInterval, format: String) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    let df = DateFormatter()
    df.dateFormat = format
    return df.string(from: date)
  }
  
  private func iconByType(_ type: String) -> UIImage {
    return UIImage(named: type) ?? UIImage(named: "none")!
  }
  
  private func tempByCountry(_ country: String, temp: Double) -> Double {
    if country == "US" {
      return round(((temp - 273.15) * 1.8) + 32)
    } else {
      return round(temp - 273.15)
    }
  }
}
