//
//  ViewController.swift
//  UIPageViewController Post
//
//  Created by Maor Shams on 05/05/2017.
//  Copyright © 2017 Maor Shams. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var pageViewVC: PageViewVC? {
        didSet {
            pageViewVC?.pageViewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(didChangePageControlValue), forControlEvents: .ValueChanged)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tutorialPageViewController = segue.destinationViewController as? PageViewVC {
            self.pageViewVC = tutorialPageViewController
        }
    }
    
    // When the user taps on the pageControl to change its current page.
    func didChangePageControlValue() {
        pageViewVC?.scrollTo(index: pageControl.currentPage)
    }
    
}

extension PageViewController: PageViewVCDelegate {
    
    func didUpdatePageCount(vc: PageViewVC, count: Int) {
        pageControl.numberOfPages = count
    }
    
    func didUpdatePageIndex(vc: PageViewVC, index: Int) {
        pageControl.currentPage = index
    }
}
