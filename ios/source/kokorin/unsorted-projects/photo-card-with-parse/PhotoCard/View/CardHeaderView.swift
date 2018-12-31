//
//  CardHeaderView.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CardHeaderView: UIView {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var cardDescriptionLabel: UILabel!
  @IBOutlet weak var numberOfComments: UILabel!
  
  var card: Card! {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    //backgroundImageView.image = card.image
    cardDescriptionLabel.text = card.description
    numberOfComments.text = "\(card.comments) comments"
  }
  
}
