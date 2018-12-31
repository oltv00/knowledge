//
//  TimelineViewController.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit
import ParseUI

class TimelineViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var currentUserFullNameButton: UIButton!
  
  var cards = [Card]()
  
  // MARK: - View life cycles
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if PFUser.current() == nil {
      // user hasn't logged
      presentLoginViewController()
    } else {
      // user has logged
      fetchCards()
    }
    
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // add blur effect
    backgroundImageView.image = UIImage(named: "cloud")
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    // iPhone 4 and 5 collection view cell size support
    if UIScreen.main.bounds.size.height == 480.0 || UIScreen.main.bounds.size.height == 568.0 {
      let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      flowLayout.itemSize = CGSize(width: 250.0, height: 200.0)
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - API
  
  func fetchCards() {
    let currentUser = User.current()!
    
    guard let cardIds = currentUser.cardIds else {
      return
    }
    
    if cardIds.count > 0 {
      let cardQuery = PFQuery(className: Card.parseClassName())
      cardQuery.order(byDescending: "updatedAt")
      cardQuery.whereKey("objectId", containedIn: cardIds)
      
      cardQuery.findObjectsInBackground(block: { (objects, error) in
        if error != nil {
          print(error!.localizedDescription)
        } else {
          
          if let cardObjects = objects as [PFObject]? {
            self.cards.removeAll()
            
            for cardObject in cardObjects {
              let card = cardObject as! Card
              self.cards.append(card)
            }
            
            self.collectionView.reloadData()
          }
        }
      })
    }
  }
  
  // MARK: - Action
  
  @IBAction func actionUserProfileButton(_ sender: UIButton) {
    PFUser.logOut()
    presentLoginViewController()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowCard" {
      let nav = segue.destination as! UINavigationController
      let vc = nav.topViewController as! CardViewController
      let cell = sender as! CardCollectionViewCell
      vc.card = cell.card
    }
  }
  
}

// MARK: - UICollectionViewDataSource

extension TimelineViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
    
    cell.card = self.cards[indexPath.item]
    
    return cell
  }
}

// MARK: - PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate

extension TimelineViewController: PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
  func presentLoginViewController() {
    let loginViewController = PFLogInViewController()
    let signUpViewController = PFSignUpViewController()
    loginViewController.delegate = self
    signUpViewController.delegate = self
    
    loginViewController.fields = [.usernameAndPassword, .logInButton, .signUpButton]
    loginViewController.signUpController = signUpViewController
    
    present(loginViewController, animated: true, completion: nil)    
  }
  
  func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
    logInController.dismiss(animated: true, completion: nil)
  }
  
  func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
    signUpController.dismiss(animated: true, completion: nil)
  }
}







