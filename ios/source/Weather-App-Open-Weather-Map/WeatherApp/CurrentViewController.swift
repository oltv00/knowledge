//
//  ViewController.swift
//  WeatherApp
//
//  Created by Oleg Tverdokhleb on 11/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentViewController: UIViewController, OpenWeatherMapDelegate, CLLocationManagerDelegate {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  // MARK: - Properties
  
  let openWeather = OpenWeatherMap.shared
  let hud = MBProgressHUD()
  let locationManager = CLLocationManager()
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let bg = UIImage(named: "background")
    self.view.backgroundColor = UIColor(patternImage: bg!)
    addBlurEffect()
    
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    
    openWeather.delegate = self
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }

  // MARK: - Helper funcs
  
  func addBlurEffect() {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = self.view.bounds
    self.view.insertSubview(blurView, at: 0)
  }
  
  func displayCity() {
    
    let alert = UIAlertController(title: "City", message: "Enter name city", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    let ok = UIAlertAction(title: "OK", style: .default) { (action) in
      if let textField = alert.textFields?.first {
        self.activityIndicator()
        self.openWeather.currentWeatherFor(textField.text!)
      }
    }
    
    alert.addTextField { (textField) in
      textField.placeholder = "City name"
    }
    
    alert.addAction(ok)
    alert.addAction(cancel)
    self.present(alert, animated: true, completion: nil)
  }
  
  func activityIndicator() {
    hud.label.text = "Loading..."
    hud.center = self.view.center
    self.view.addSubview(hud)
    hud.show(animated: true)
  }
  
  // MARK: - Actions
  
  @IBAction func actionCity(_ sender: UIButton) {
    displayCity()
  }

  // MARK: - OpenWeatherMapDelegate
  
  func didUpdateWeatherInfo() {
    hud.hide(animated: true)
    
    cityNameLabel.text = "\(openWeather.nameCity!) \(openWeather.country!)"
    timeLabel.text = "At \(openWeather.currentTime!) it is"
    tempLabel.text = String(openWeather.temp!) + "°"
    windSpeedLabel.text = String(openWeather.windSpeed!)
    humidityLabel.text = String(openWeather.humidity!)
    descriptionLabel.text = openWeather.description
    iconImageView.image = openWeather.icon
  }
  
  func didFailureToLoadInfo() {
    hud.hide(animated: true)
    let alert = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    self.present(alert, animated: true, completion: nil)
  }

  // MARK: - CLLocationManagerDelegate
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(manager.location)
    self.activityIndicator()
    
    if let currentLocation = locations.last {
      if currentLocation.horizontalAccuracy > 0 {
        manager.stopUpdatingLocation()
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        openWeather.currentWeatherFor(location)
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}

