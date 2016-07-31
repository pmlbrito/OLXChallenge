//
//  APIAdPhoto.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import ObjectMapper

class APIAdPhoto : Mappable {
    var riak_key: Int?
    var data: [APIAdPhotoData]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        riak_key <- map["riak_key"]
        data <- map["data"]
    }
}
