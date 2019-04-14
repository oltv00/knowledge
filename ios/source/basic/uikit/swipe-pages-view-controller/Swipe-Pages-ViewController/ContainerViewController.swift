//
//  ContainerViewController.swift
//  Swipe-Pages-ViewController
//
//  Created by Oleg Tverdokhleb on 09/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let pageViewController = segue.destinationViewController as? PageViewController {
      pageViewController.pageDelegate = self
    }
  }
}

extension ContainerViewController: PageViewControllerDelegate {

  func pageViewController(pageViewController: PageViewController, didUpdatePageCount count: Int) {
    pageControl.numberOfPages = count
  }
  
  func pageViewController(pageViewController: PageViewController, didUpdatePageIndex index: Int) {
    pageControl.currentPage = index
  }
}