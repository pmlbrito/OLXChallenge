//
//  OLXAPIService.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class OLXAPIService {
    
    var apiConfig: APIConfig?;
    
    static let sharedInstance = OLXAPIService();
    private init(){
        self.apiConfig = APIConfig.sharedInstance;
    }
    
    
    func fetchAds(completionHandler: (availAds: APIResponseObject?, error: NSError?) -> Void) {
    
        Alamofire.request(.GET, (apiConfig?.service_base_url)!).responseObject { (response: Response<APIResponseObject, NSError>) in
            
            let apiResponse = response.result.value
            print(apiResponse)
            
            //do stuff with the response
            completionHandler(availAds: apiResponse, error: response.result.error);
        }
    
    }
    
    
}
