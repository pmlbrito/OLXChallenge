//
//  OLXMapLocationMKAnnotation.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 31/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import Foundation
import MapKit

class OLXMapLocationMKAnnotation: NSObject, MKAnnotation {
    let title: String?
    let user_price: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, username: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.user_price = username
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return user_price
    }
}
