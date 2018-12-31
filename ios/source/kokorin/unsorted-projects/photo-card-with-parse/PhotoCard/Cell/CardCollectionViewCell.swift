//
//  CardCollectionViewCell.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var cardImageView: UIImageView!
  @IBOutlet weak var cardTitleLabel: UILabel!
  @IBOutlet weak var cardDescriptionLabel: UILabel!
  
  var card: Card! {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    cardTitleLabel.text = card.title
    cardDescriptionLabel.text = card.description
    //cardImageView.image = card.image
    card.image.getDataInBackground { (imageData, error) in
      if error != nil {
       print(error!.localizedDescription)
      } else {
        
        guard let cardImageData = imageData else {
          return
        }
        DispatchQueue.main.async {
          self.cardImageView.image = UIImage(data: cardImageData)
        }
      }
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.layer.cornerRadius = 10.0
    self.clipsToBounds = true
  }
  
}
