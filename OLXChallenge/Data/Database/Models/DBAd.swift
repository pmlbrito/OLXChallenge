//
//  DBAd.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import RealmSwift

class DBAd : Object {
    
    dynamic var category_id: String = "";
    dynamic var id: String = "";
    dynamic var url: String = "";
    dynamic var title: String = "";
    dynamic var ad_description: String = "";
    dynamic var price: String = "";
    dynamic var user: String = "";
    dynamic var created: String = "";
    
    dynamic var map_zoom: Int = 0;
    dynamic var map_lat: String = "";
    dynamic var map_lon: String = "";
    
    //will contain string concat array (to save space and object criation)
    dynamic var photos: String = "";
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getViewModel() -> AdViewModel{
        let viewModel = AdViewModel();
        viewModel.title = self.title
        viewModel.description = self.ad_description
        viewModel.price_numeric = self.price
        viewModel.user_label = self.user
        
        viewModel.map_zoom = self.map_zoom
        viewModel.map_lat = self.map_lat
        viewModel.map_lon = self.map_lon
        
        viewModel.photos = self.photos.characters.split{$0 == "±"}.map(String.init)
     
        return viewModel;
    }

    static func getStringToStoreFromPhotos(photos: [String]) -> String {
        var retString = "";
        if(photos.count > 0){
            retString = photos.joinWithSeparator("±");
        }
        
        return retString;
    }
    
}
