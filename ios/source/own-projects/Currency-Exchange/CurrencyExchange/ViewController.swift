//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Oleg Tverdokhleb on 29/08/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import APIManagerKit

class ViewController: UIViewController {
  
  // All labels
  @IBOutlet var allValueLabels: [UILabel]!
  
  // Moscow Exchange labels
  @IBOutlet weak var MEUSDMaxLabel: UILabel!
  @IBOutlet weak var MEUSDMinLabel: UILabel!
  @IBOutlet weak var MEUSDLastLabel: UILabel!
  @IBOutlet weak var MEUSDPrcntLabel: UILabel!
  
  @IBOutlet weak var MEEURMaxLabel: UILabel!
  @IBOutlet weak var MEEURMinLabel: UILabel!
  @IBOutlet weak var MEEURLastLabel: UILabel!
  @IBOutlet weak var MEEURPrcntLabel: UILabel!
  
  // Central Bank labels
  @IBOutlet weak var CBUSDTodayLabel: UILabel!
  @IBOutlet weak var CBEURTodayLabel: UILabel!
  @IBOutlet weak var CBUSDTomorrowLabel: UILabel!
  @IBOutlet weak var CBEURTomorrowLabel: UILabel!
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - View life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    print("ViewController viewDidLoad")
    //self.view.backgroundColor = UIColor(red:0.06, green:0.14, blue:0.26, alpha:1.00)
    initFirstLaunchLabels()
    updateTodayCentralBankCurrency()
    updateTomorrowCentralBankCurrency()
    updateMoscowExchangeCurrency()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Helper methods
  func initFirstLaunchLabels() {
    for label in allValueLabels {
      label.text = "-"
    }
  }
  
  // MARK: - APIManager methods
  // MARK: - Central Bank methods
  func updateTodayCentralBankCurrency() {
    APIManager.shared.getTodayCentralBankCurrency { (currency, error) in
      if error != nil {
        // TODO: Show alert - no internet
      } else {
        self.CBUSDTodayLabel.text = currency!.usdValue
        self.CBEURTodayLabel.text = currency!.eurValue
      }
    }
  }
  
  func updateTomorrowCentralBankCurrency() {
    APIManager.shared.getTomorrowCentralBankCurrency { (currency, error) in
      if error != nil {
        // TODO: Show alert - no internet
      } else {
        self.CBUSDTomorrowLabel.text = currency!.usdValue
        self.CBEURTomorrowLabel.text = currency!.eurValue
      }
    }
  }
  
  //MARK: - Moscow Exchange methods
  func updateMoscowExchangeCurrency() {
    APIManager.shared.getMEUSD { (USD) in
      self.MEUSDLastLabel.text = USD.last
      self.MEUSDMaxLabel.text = USD.max
      self.MEUSDMinLabel.text = USD.min
      self.MEUSDPrcntLabel.text = USD.prcnt
    }
    
    APIManager.shared.getMEEUR { (EUR) in
      self.MEEURLastLabel.text = EUR.last
      self.MEEURMaxLabel.text = EUR.max
      self.MEEURMinLabel.text = EUR.min
      self.MEEURPrcntLabel.text = EUR.prcnt
    }
  }
}

