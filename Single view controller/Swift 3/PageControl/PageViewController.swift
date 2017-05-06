//
//  PhotoVC.swift
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
        pageControl.addTarget(self, action: #selector(didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? PageViewVC {
            self.pageViewVC = destVC
        }
    }
    
    // When the user taps on the pageControl to change its current page.
    func didChangePageControlValue() {
        pageViewVC?.scrollTo(index: pageControl.currentPage)
    }
    
}

extension PageViewController: PageViewVCDelegate {
    // number of pages
    func didUpdatePageCount(_ vc: PageViewVC, count: Int) {
        pageControl.numberOfPages = count
    }
    // current page
    func didUpdatePageIndex(_ vc: PageViewVC, index: Int) {
        pageControl.currentPage = index
    }
}
