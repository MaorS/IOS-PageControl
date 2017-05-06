//
//  ViewController.swift
//  UIPageViewController Post
//
//  Created by Maor Shams on 05/05/2017.
//  Copyright © 2017 Seven Even. All rights reserved.
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
        pageControl.addTarget(self, action: #selector(didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? PageViewVC {
            self.pageViewVC = tutorialPageViewController
        }
    }
    
    // When the user taps on the pageControl to change its current page.
    func didChangePageControlValue() {
        pageViewVC?.scrollTo(index: pageControl.currentPage)
    }
    
}

extension PageViewController: PageViewVCDelegate {
    
    func didUpdatePageCount(_ vc: PageViewVC, count: Int) {
        pageControl.numberOfPages = count
    }
    
    func didUpdatePageIndex(_ vc: PageViewVC, index: Int) {
        pageControl.currentPage = index
    }
}
