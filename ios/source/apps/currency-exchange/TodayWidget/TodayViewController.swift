//
//  TodayViewController.swift
//  TodayWidget
//
//  Created by Oleg Tverdokhleb on 06/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import NotificationCenter
import APIManagerKit

class TodayViewController: UIViewController, NCWidgetProviding {
  
  // All labels
  @IBOutlet var allValueLabels: [UILabel]!
  
  // Moscow Exchange labels
  @IBOutlet weak var MEUSDLabel: UILabel!
  @IBOutlet weak var MEEURLabel: UILabel!
  
  // Central Bank labels
  @IBOutlet weak var CBUSDTodayLabel: UILabel!
  @IBOutlet weak var CBEURTodayLabel: UILabel!
  @IBOutlet weak var CBUSDTomorrowLabel: UILabel!
  @IBOutlet weak var CBEURTomorrowLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view from its nib.
    print("TodayViewController viewDidLoad")
    initFirstLaunchLabels()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateWidget()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Helper methods
  func initFirstLaunchLabels() {
    for label in allValueLabels {
      label.text = "--"
    }
  }
  
  func widgetMarginInsets
    (forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
    return UIEdgeInsets.zero
  }
  
  // MARK: - APIManager methods
  
  func updateWidget() {
    print("updateWidget")
    
    APIManager.shared.getMEUSD { (USD) in
      self.MEUSDLabel.text = USD.last
    }
    
    APIManager.shared.getMEEUR { (EUR) in
      self.MEEURLabel.text = EUR.last
    }
    
    APIManager.shared.getTodayCentralBankCurrency { (currency, error) in
      if error != nil {
        self.CBUSDTodayLabel.text = "--"
        self.CBEURTodayLabel.text = "--"
      } else {
        self.CBUSDTodayLabel.text = currency!.usdValue
        self.CBEURTodayLabel.text = currency!.eurValue
      }
    }
    
    APIManager.shared.getTomorrowCentralBankCurrency { (currency, error) in
      if error != nil {
        self.CBUSDTomorrowLabel.text = "--"
        self.CBEURTomorrowLabel.text = "--"
      } else {
        self.CBUSDTomorrowLabel.text = currency!.usdValue
        self.CBEURTomorrowLabel.text = currency!.eurValue
      }
    }
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    
    print("widgetPerformUpdateWithCompletionHandler")
    print("NCUpdateResult.NewData = \(NCUpdateResult.newData.rawValue)")
    print("NCUpdateResult.NoData = \(NCUpdateResult.noData)")
    print("NCUpdateResult.Failed = \(NCUpdateResult.failed)")
    
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    completionHandler(NCUpdateResult.newData)
    updateWidget()
  }
  
}
