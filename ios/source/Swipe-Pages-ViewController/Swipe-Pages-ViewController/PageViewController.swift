//
//  PageViewController.swift
//  Swipe-Pages-ViewController
//
//  Created by Oleg Tverdokhleb on 09/09/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
  
  private var orderedViewControllers: [UIViewController]!
  weak var pageDelegate: PageViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    delegate = self
    
    setupViewControllers()
    setupDelegate()
  }
  
  func setupViewControllers() {
    let red = storyboard!.instantiateViewControllerWithIdentifier("RedViewController")
    let green = storyboard!.instantiateViewControllerWithIdentifier("GreenViewController")
    let blue = storyboard!.instantiateViewControllerWithIdentifier("BlueViewController")
    let controllers = [red, green, blue]
    orderedViewControllers = controllers
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
    }
  }
  
  func setupDelegate() {
    pageDelegate?.pageViewController(self, didUpdatePageCount: orderedViewControllers.count)
  }
}

// MARK - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
      return orderedViewControllers.last
    }
    
    guard orderedViewControllers.count > previousIndex else {
      return nil
    }
    
    return orderedViewControllers[previousIndex]
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
      return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    
    guard orderedViewControllers.count != nextIndex else {
      return orderedViewControllers.first
    }
    
    guard orderedViewControllers.count > nextIndex else {
      return nil
    }
    
    return orderedViewControllers[nextIndex]
  }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
  func pageViewController(pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                                             previousViewControllers: [UIViewController],
                                             transitionCompleted completed: Bool) {
    if let firstViewController = viewControllers?.first, let index = orderedViewControllers.indexOf(firstViewController) {
      pageDelegate?.pageViewController(self, didUpdatePageIndex: index)
    }
  }
}

protocol PageViewControllerDelegate: class {
  func pageViewController(pageViewController: PageViewController, didUpdatePageCount count: Int)
  func pageViewController(pageViewController: PageViewController, didUpdatePageIndex index: Int)
}




