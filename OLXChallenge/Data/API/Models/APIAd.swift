//
//  APIAd.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//


import ObjectMapper
import QuickShotUtils

class APIAd : Mappable {
    var id: String?
    var url: String?
    var title: String?
    var description: String?
    var price_numeric: String?
    var user_label: String?
    var created: String?
    
    var map_zoom: String?
    var map_lat: String?
    var map_lon: String?
    
    var photos: APIAdPhoto?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        title <- map["title"]
        description <- map["description"]
        price_numeric <- map["price_numeric"]
        user_label <- map["user_label"]
        created <- map["created"]
        map_zoom <- map["map_zoom"]
        map_lat <- map["map_lat"]
        map_lon <- map["map_lon"]
        photos <- map["photos"]
    }
    
    func toDBObject(category_id: String) -> DBAd {
        let retObj = DBAd();
        retObj.category_id = category_id;
        
        retObj.id = isNilOrEmpty(self.id) ? "" : self.id!;
        
        retObj.url = isNilOrEmpty(self.url) ? "" : self.url!;
        retObj.title = isNilOrEmpty(self.title) ? "" : self.title!;
        retObj.ad_description = isNilOrEmpty(self.description) ? "" : self.description!;
        retObj.price = isNilOrEmpty(self.price_numeric) ? "" : self.price_numeric!;
        retObj.user = isNilOrEmpty(self.user_label) ? "" : self.user_label!;
        
        retObj.created = isNilOrEmpty(self.created) ? "" : self.created!;
        
        retObj.map_zoom = self.map_zoom == nil ? 12 : Int(self.map_zoom!)!;
        retObj.map_lat = isNilOrEmpty(self.map_lat) ? "" : self.map_lat!;
        retObj.map_lon = isNilOrEmpty(self.map_lon) ? "" : self.map_lon!;
        
        //will contain string concat array (to save space and object criation)
        retObj.photos = "";
        
        var photosUrls = [String]();
        if(self.photos != nil && !isNilOrEmpty(self.photos?.data)){
            for photo in self.photos!.data! {
                let imgPath = String(format: APIConfig.sharedInstance.imgs_path_format, "\(self.photos!.riak_key!)", "\(photo.slot_id!)");
                let photoUrl = String(format:"%@%@", APIConfig.sharedInstance.imgs_api_base_url!, imgPath);
            
                photosUrls.append(photoUrl);
            }
        
            retObj.photos = photosUrls.joinWithSeparator("±");
        }
    
        return retObj;
    }
}

