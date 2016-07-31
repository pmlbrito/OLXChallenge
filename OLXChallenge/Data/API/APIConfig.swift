//
//  APIConfig.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import Foundation
import QuickShotUtils

class APIConfig {
    
    static let sharedInstance = APIConfig(configFile: "APIConfig");
    
    var service_base_url: String?;
    var imgs_api_base_url: String?
    let imgs_path_format = "%@_%@_.jpg"

    private init(configFile: String){
        if(!isNilOrEmpty(configFile)){
            let apiConfig = AppUtils.getPListFileForBundleConfigKey(configFile);
            let configDictionary = NSMutableDictionary(dictionary: apiConfig!);
            self.setConfig(configDictionary);
        }
    }
    
    func setConfig(configDict: NSDictionary?){
        if(configDict != nil){
            self.service_base_url = configDict!["API_REQUEST_URL"] as? String;
            self.imgs_api_base_url = configDict!["API_BASE_PHOTO_URL"] as? String;
        }
    }
}
