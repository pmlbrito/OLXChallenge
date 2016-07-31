//
//  APIResponseObject.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 29/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import ObjectMapper

class APIResponseObject : Mappable {
    var category_id: String?
    var page: Int?
    var ads_on_page: Int?
    var next_page_url: String?
    
    var ads: [APIAd]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        category_id <- map["category_id"]
        page <- map["page"]
        ads_on_page <- map["ads_on_page"]
        next_page_url <- map["next_page_url"]
        ads <- map["ads"]
    }
}

