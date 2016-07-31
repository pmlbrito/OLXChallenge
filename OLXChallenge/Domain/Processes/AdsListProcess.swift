//
//  AdsListProcess.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import Foundation
import Async

class AdsListProcess {
    
    var apiService: OLXAPIService;
    //var dbService: OLXDatabseService; -> this is actually not needed because the service is static (each service call needs it's thread dbHelper)
    
    init(){
        self.apiService = OLXAPIService.sharedInstance;
    }
    
    
    func getAds(category_id: String, completionHandler: (availAds: Array<AdViewModel>) -> Void){
    
        Async.background{
            self.apiService.fetchAds { (availAds, error) -> Void in
            
            //store in DB
            let dbHelper = OLXDatabseService.getRealmHelper();
            
                if(availAds != nil){
                    OLXDatabseService.storeAds(dbHelper, ads: availAds!);
                }
                
                Async.main {
                    
                    //load info from DB
                    let dbHelper = OLXDatabseService.getRealmHelper();
                    
                    let loadedAds = OLXDatabseService.fetchAds(dbHelper, category_id: category_id);
                
                    //call view controller handler
                    var viewAds = Array<AdViewModel>()
                    for ad in loadedAds {
                        viewAds.append(ad.getViewModel());
                    }
                    
                    completionHandler(availAds: viewAds);
                }
            }
        }
    }

}