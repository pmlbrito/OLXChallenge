//
//  AdDetailUIViewController.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 31/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit
import QuickShotUtils
import Kingfisher

class AdDetailUIViewController : UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var itemPhoto: UIImageView!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var photosButton: UIButton!
    
    
    var adItem: AdViewModel!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.setViewValues();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setDetailViewData(viewModel: AdViewModel){
        self.adItem = viewModel;
    }
    
    func setViewValues(){
        self.titleLabel.text = adItem.title;
        self.descriptionLabel.text = adItem.description;
        self.userLabel.text = adItem.user_label;
        self.priceLabel.text = !isNilOrEmpty(adItem.price_numeric) ? String(format:"%@ €", adItem.price_numeric!) : "";
        
        if(!isNilOrEmpty(self.adItem.photos)){
            let keyURL = NSURL(string:self.adItem.photos!.first!!)
            let resource = Resource(downloadURL:  keyURL!, cacheKey: keyURL!.URLString)
            self.itemPhoto.kf_setImageWithResource(resource,
                                                   placeholderImage: UIImage(named: "detail_img_placeholder"),
                                                   optionsInfo: [.Transition(ImageTransition.Fade(1))]);
            
        }
        
        if(isNilOrEmpty(self.adItem.map_lat) || isNilOrEmpty(self.adItem.map_lon)){
            self.mapButton.hidden = true;
        }
        
        if(isNilOrEmpty(self.adItem.photos) || isNilOrEmpty(self.adItem.photos)){
            self.photosButton.hidden = true;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "AdDetailToMapSegue" {
            // Setup new view controller
            let nextVC = segue.destinationViewController as! AdMapUIViewController;
            nextVC.setDetailViewData(self.adItem);
        }
        
        if segue.identifier == "AdDetailToPhotosSegue" {
            let nextVC = segue.destinationViewController as! AdPhotosUIViewController;
            nextVC.setDetailViewData(self.adItem);
        }
    }
}