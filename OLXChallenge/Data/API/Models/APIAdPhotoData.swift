//
//  APIAdPhotoData.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import ObjectMapper

class APIAdPhotoData : Mappable {
    var slot_id: Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        slot_id <- map["slot_id"]
    }
}
