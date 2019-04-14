//
//  CommentTableViewCell.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
  
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var createdAtLabel: UILabel!
  @IBOutlet weak var commentTextLabel: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  
  private var currentUserDidLike = false
  
  // MARK: - Helper funcs
  
  var comment: Comment! {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
//    userProfileImageView.image = comment.user.profileImage
//    userNameLabel.text = comment.user.fullName
//    createdAtLabel.text = comment.createdAt
    commentTextLabel.text = comment.commentText
    likeButton.setTitle("❤️ \(comment.numberOfLikes) likes", for: .normal)
    
    userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width / 2
    userProfileImageView.clipsToBounds = true
    
  }
  
  private func changeLikeButtonColor() {
    if currentUserDidLike {
      likeButton.tintColor = UIColor.red
    } else {
      likeButton.tintColor = UIColor.lightGray
    }
  }
  
  // MARK: - Action
  
  @IBAction func actionLikeButton(_ sender: UIButton) {
//    comment.userDidLike = !comment.userDidLike
    
//    if comment.userDidLike {
//      comment.numberOfLikes += 1
//    } else {
//      comment.numberOfLikes -= 1
//    }
    
    likeButton.setTitle("❤️ \(comment.numberOfLikes) likes", for: .normal)
//    currentUserDidLike = comment.userDidLike
    changeLikeButtonColor()
  }
}





