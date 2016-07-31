//
//  AdPhotosUIViewController.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 31/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit
import ImageSlideshow


class AdPhotosUIViewController: UIViewController {
    
    @IBOutlet var slideshow: ImageSlideshow!
    var transitionDelegate: ZoomAnimatedTransitioningDelegate?
    
    var adItem: AdViewModel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewValues();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDetailViewData(viewModel: AdViewModel){
        self.adItem = viewModel;
    }
    
    func setViewValues(){
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
        slideshow.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        
        var photoSources = [AlamofireSource]()
        for photo in adItem.photos! {
            photoSources.append(AlamofireSource(urlString: photo!)!)
        }
        
        slideshow.setImageInputs(photoSources)
    }
}


