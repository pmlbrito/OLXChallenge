//
//  AdsPagerViewController.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 31/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit

class AdsPagerViewController: UIPageViewController {
    
    var adsLoaded: [AdViewModel]!;
    var initialViewIndex: Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        scrollToViewController(index: initialViewIndex)
    }
    
    
    func setPagerData(pagerData: [AdViewModel]?, initialViewIndex: Int){
        self.adsLoaded = pagerData;
        self.initialViewIndex = initialViewIndex;
    }
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfterViewController: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first {
            let currentIndex = adsLoaded.indexOf { p in
                firstViewController.title == p.title
            }
            
            if(currentIndex != nil){
                let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .Forward : .Reverse
                
                let nextViewModel = adsLoaded[newIndex]
                
                let nextPage = newAdDetailViewController();
                nextPage.setDetailViewData(nextViewModel);
                
                scrollToViewController(nextPage, direction: direction)
            }
        }else{
                let direction: UIPageViewControllerNavigationDirection = .Forward
                
                let nextViewModel = adsLoaded[newIndex]
                
                let nextPage = newAdDetailViewController()
                nextPage.setDetailViewData(nextViewModel);
                
                scrollToViewController(nextPage, direction: direction)
        }
    }
    
    private func newAdDetailViewController() -> AdDetailUIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("AdDetailUIViewController") as! AdDetailUIViewController
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewControllerNavigationDirection = .Forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    private func notifyTutorialDelegateOfNewIndex() {
        let firstViewController = viewControllers?.first
        if(firstViewController != nil){
            let viewControllerIndex = adsLoaded.indexOf { p in
                firstViewController!.title == p.title
            }
            
            if(viewControllerIndex != nil){
                //tutorialDelegate?.tutorialPageViewController(self, didUpdatePageIndex: index)
            }
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension AdsPagerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let viewControllerModel = (viewController as! AdDetailUIViewController).adItem
        
        let viewControllerIndex = adsLoaded.indexOf { p in
            viewControllerModel.title == p.title
        }
        
        if(viewControllerIndex == nil){
            return nil
        }
        
        
        let previousIndex = viewControllerIndex! - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            let nextModel = adsLoaded.last
            
            let page = newAdDetailViewController();
            page.setDetailViewData(nextModel!);
            return page;
        }
        
        guard adsLoaded.count > previousIndex else {
            return nil
        }
        
        let previousModel = adsLoaded[previousIndex]
        let page = newAdDetailViewController();
        page.setDetailViewData(previousModel);
        return page;
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let viewControllerModel = (viewController as! AdDetailUIViewController).adItem
        
        let viewControllerIndex = adsLoaded.indexOf { p in
            viewControllerModel.title == p.title
        }
        
        if(viewControllerIndex == nil){
            return nil
        }
        
        let nextIndex = viewControllerIndex! + 1
        let orderedViewControllersCount = adsLoaded.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            let nextModel = adsLoaded.first
            
            let page = newAdDetailViewController();
            page.setDetailViewData(nextModel!);
            return page;
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        
        let nextModel = adsLoaded[nextIndex]
        let page = newAdDetailViewController();
        page.setDetailViewData(nextModel);
        return page;
    }
    
}

extension AdsPagerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

protocol TutorialPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: AdsPagerViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: AdsPagerViewController,
                                    didUpdatePageIndex index: Int)
    
}
