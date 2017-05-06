//
//  PhotoVC.swift
//  UIPageViewController Post
//
//  Created by Maor Shams on 05/05/2017.
//  Copyright © 2017 Maor Shams. All rights reserved.
//

import UIKit

class PageViewVC: UIPageViewController {
    
    weak var pageViewDelegate: PageViewVCDelegate?
    var photos = ["screenshot_1", "screenshot_2", "screenshot_3"]
    var currentIndex: Int?
    
    private var controllers: [PhotoVC] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        
        // The view controllers will be shown in this order
        if let vc1 = instantiateVC(0){
            controllers.append(vc1)
        }
        
        if let vc2 = instantiateVC(1){
            controllers.append(vc2)
        }
        
        if let vc3 = instantiateVC(2){
            controllers.append(vc3)
        }
        
        //  setup the UIPageViewController by passing it an array that contains the single view controller
        if let viewController = instantiateVC(currentIndex ?? 0){
            let viewControllers = [viewController]
            setViewControllers(viewControllers,
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        pageViewDelegate?.didUpdatePageCount(self, count: photos.count)
    }
    
    
    // Scroll to view controller with given index
    func scrollTo(index newIndex: Int) {
        guard let firstViewController = viewControllers?.first else{
            return
        }
        guard let vc = firstViewController as? PhotoVC else{
            return
        }
        guard let currentIndex = vc.photoIndex  else {
            return
        }
        
        let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .Forward : .Reverse
        let nextVC = controllers[newIndex]
        
        self.scrollTo(nextVC,direction: direction)
    }
    
    // instantiate View controller with index
    func instantiateVC( index: Int)-> PhotoVC?{
        guard let storyboard = storyboard else{
            return nil
        }
        
        guard let page = storyboard.instantiateViewControllerWithIdentifier("PhotoVC") as? PhotoVC else{
            return nil
        }
        
        page.photoName = photos[index]
        page.photoIndex = index
        
        return page
    }
    
    
    // scroll to view controller, by default forward
    func scrollTo(vc : UIViewController, direction : UIPageViewControllerNavigationDirection = .Forward){
        setViewControllers([vc], direction: direction, animated: true) { _ in
            self.notifyDelegateOfNewIndex()
        }
    }
    
    // Notifies 'PageViewDelegate' that the current page index was updated.
    private func notifyDelegateOfNewIndex() {
        
        guard let firstViewController = viewControllers?.first else {
            return
        }
        
        guard let vc = firstViewController as? PhotoVC else{
            return
        }
        
        guard let index = vc.photoIndex else{
            return
        }
        pageViewDelegate?.didUpdatePageIndex(self, index: index)
    }
    
    
    
}

// MARK: UIPageViewControllerDataSource

extension PageViewVC: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? PhotoVC else{
            return nil
        }
        
        guard var index = viewController.photoIndex else{
            return nil
        }
        
        guard index != NSNotFound && index != 0 else {
            return nil
        }
        
        index -= 1
        
        return instantiateVC(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewController = viewController as? PhotoVC else {
            return nil
        }
        
        guard var index = viewController.photoIndex else{
            return nil
        }
        
        guard index != NSNotFound else {
            return nil
        }
        
        index += 1
        
        guard index != photos.count else {
            return nil
        }
        
        return instantiateVC(index)
        
    }
    
}

extension PageViewVC: UIPageViewControllerDelegate {
    // each swipe, notify delegate
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyDelegateOfNewIndex()
    }
}

protocol PageViewVCDelegate : class {
    
    // Called when the number of pages is updated.
    func didUpdatePageCount(vc : PageViewVC, count : Int)
    
    // Called when the current index is updated.
    func didUpdatePageIndex(vc : PageViewVC, index : Int)
}
