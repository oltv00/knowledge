//
//  TodayViewController.swift
//  WeatherWidget
//
//  Created by Oleg Tverdokhleb on 26/09/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherDataKit

class TodayViewController: UIViewController, NCWidgetProviding, WeatherDataDelegate {
  
  enum ResponseState {
    case successed, failured
  }
  
  // MARK: - IBOutlelts
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var descrLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  
  // MARK: - Properties
  
  var weather = WeatherData()
  var location = "No location"
  var responseState: ResponseState!
  
  var defaults = UserDefaults(suiteName: "group.com.oltv00.Today-Extension")
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view from its nib.
    
    weather.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateLocation()
    weather.weatherBy(cityName: location)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    updateLocation()
    
    if responseState == ResponseState.successed {
      didUpdateWeatherData()
      completionHandler(.newData)
    } else {
      completionHandler(.noData)
    }
  }
  
  // MARK: - Helper methods
  
  func updateLocation() {
    if let defaultLocation = defaults?.value(forKey: "city") as? String {
      location = defaultLocation
      print("updateLocation = " + location)
    }
  }
  
  // MARK: - WeatherDataDelegate
  
  func didUpdateWeatherData() {
    responseState = .successed
    cityLabel.text = location
    tempLabel.text = weather.temperature + "\u{00b0}"
    descrLabel.text = weather.description
  }
  
  func didFailureWeatherData() {
    responseState = .failured
    cityLabel.text = "No location"
    tempLabel.text = "0.0"
    descrLabel.text = "Not found city"
  }
  
}
