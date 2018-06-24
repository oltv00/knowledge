//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Oleg Tverdokhleb on 17/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController, OpenWeatherMapDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: - Properties
  
  var forecasts = [Forecast]()
  let openWeather = OpenWeatherMap.shared
  let hud = MBProgressHUD()
  let locationManager = CLLocationManager()
  
  // MARK: - View life cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let bg = UIImage(named: "background")
    self.view.backgroundColor = UIColor(patternImage: bg!)
    addBlurEffect()
    
    openWeather.delegate = self
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Helper funcs
  
  func activityIndicator() {
    hud.label.text = "Loading..."
    hud.center = self.view.center
    self.view.addSubview(hud)
    hud.show(animated: true)
  }
  
  func addBlurEffect() {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = self.view.bounds
    self.view.insertSubview(blurView, at: 0)
  }
  
  // MARK: - OpenWeatherMapDelegate
  
  func didUpdateWeatherInfo() {
    hud.hide(animated: true)
    forecasts = openWeather.forecasts
    collectionView.reloadData()
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
    self.activityIndicator()
    
    if let currentLocation = locations.last {
      if currentLocation.horizontalAccuracy > 0 {
        manager.stopUpdatingLocation()
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        openWeather.forecastWeatherFor(location)
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
  
  // MARK: - UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return forecasts.count
  }
  
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCollectionViewCell
    
    cell.tempLabel.text = String(forecasts[indexPath.item].temp!) + "°"
    cell.iconImageView.image = forecasts[indexPath.item].icon
    cell.timeLabel.text = forecasts[indexPath.item].date
    
    return cell
  }
  
  // MARK: - UICollectionViewDelegate
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let frame = cell.frame
    if indexPath.item % 2 == 0 {
      cell.frame = CGRect(x: frame.size.width / 2 - 500, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    } else {
      cell.frame = CGRect(x: frame.size.width / 2 + 500, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    }
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      cell.frame = frame
    })
  }
}
