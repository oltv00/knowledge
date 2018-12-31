//
//  CardViewController.swift
//  PhotoCard
//
//  Created by Oleg Tverdokhleb on 14/11/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var tableView: UITableView!
  
  private var headerView: CardHeaderView!
  private var headerMaskLayer: CAShapeLayer!
  
  var tableHeaderHeight: CGFloat = 350.0
  var card: Card!
  var comments = [Comment]()
  var newCommentButton: ActionButton!
  
  // MARK: - Life view cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // self sizing class
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableViewAutomaticDimension
    
    // header setup
    headerView = tableView.tableHeaderView as! CardHeaderView
    tableView.tableHeaderView = nil
    tableView.addSubview(headerView)
    headerView.card = card
    
    // table view content size setup
    tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
    
    //header mask setup
    headerMaskLayer = CAShapeLayer()
    headerMaskLayer.fillColor = UIColor.black.cgColor
    headerView.layer.mask = headerMaskLayer
    
    updateHeaderView()
    fetchComment()
    createNewCommentButton()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    updateHeaderView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updateHeaderView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  // MARK: - Helper funcs
  
  func updateHeaderView() {
    var headerRect = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
    
    if tableView.contentOffset.y < -tableHeaderHeight {
      headerRect.origin.y = tableView.contentOffset.y
      headerRect.size.height = -tableView.contentOffset.y
    }
    
    headerView.frame = headerRect
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: headerRect.width, y: 0))
    path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
    path.addLine(to: CGPoint(x: 0, y: headerRect.height))
    headerMaskLayer?.path = path.cgPath
  }
  
  func fetchComment() {
    //comments = Comment.allComment
    tableView.reloadData()
  }
  
  func createNewCommentButton() {
    newCommentButton = ActionButton(attachedToView: view, items: [])
    newCommentButton.action = { [unowned self] button in
      self.performSegue(withIdentifier: "ShowComment", sender: nil)
    }
  }
}

// MARK: - UITableViewDataSource

extension CardViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
    
    cell.comment = comments[indexPath.row]
    
    return cell
  }
}

// MARK: - UIScrollViewDelegate

extension CardViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeaderView()
    
    let offsetY = scrollView.contentOffset.y
    let adjustment: CGFloat = 100.0
    
    if (-offsetY) > (tableHeaderHeight + adjustment) {
      self.dismiss(animated: true, completion: nil)
    }
  }
}


