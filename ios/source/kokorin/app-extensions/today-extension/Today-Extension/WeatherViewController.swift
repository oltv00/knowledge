//
//  ViewController.swift
//  Today-Extension
//
//  Created by Oleg Tverdokhleb on 22/09/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import WeatherDataKit

class WeatherViewController: UIViewController, WeatherDataDelegate {
  
  // MARK: - Constants
  let showCitySegueIdentifier = "showCity"
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  // MARK: Properties
  
  var city = ""
  var country = ""
  let weather = WeatherData()
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    weather.delegate = self
    
    descriptionLabel.text = ""
    temperatureLabel.text = ""
    
    displayCurrentWeather()        
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Helper funcs
  
  func displayCurrentWeather() {
    cityLabel.text = city
    countryLabel.text = country
  }
  
  // MARK: - Actions
  
  @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
    let source = segue.source as! CitiesTableViewController
    var selectedCity = source.selectedCity.components(separatedBy: ",")
    if selectedCity.count > 1 {
      city = selectedCity[0]
      country = selectedCity[1].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      weather.weatherBy(cityName: city)
    }
    
    displayCurrentWeather()
  }
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == showCitySegueIdentifier {
      let nc = segue.destination as! UINavigationController
      let vc = nc.viewControllers.first as! CitiesTableViewController
      vc.selectedCity = "\(city), \(country)"
    }
  }
  
  // MARK: - WeatherDataDelegate
  
  func didUpdateWeatherData() {
    temperatureLabel.text = weather.temperature + "\u{00b0}"
    descriptionLabel.text = weather.description
  }
  
  func didFailureWeatherData() {
    temperatureLabel.text = "0.0"
    descriptionLabel.text = "Not found city"
  }
  
}

