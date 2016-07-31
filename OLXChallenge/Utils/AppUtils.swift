//
//  AppUtils.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import Foundation

class AppUtils {
    
    static func getPListFileForBundleConfigKey(filenameKey: String) -> NSDictionary? {
        let path = NSBundle.mainBundle().pathForResource(filenameKey, ofType: "plist");
        
        var dict: NSDictionary?
        dict = nil;
        if(path != nil){
            dict = NSDictionary(contentsOfFile: path!);
        }
        
        return dict;
    }
    
}