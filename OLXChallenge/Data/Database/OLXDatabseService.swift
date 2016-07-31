//
//  OLXDatabseService.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 30/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import RealmSwift
import QuickShotUtils

class OLXDatabseService {
    
    
    static func getRealmHelper() -> Realm {
        let dbHelper = try! Realm();
        dbHelper.refresh();
        return dbHelper;
    }

    static func storeAds(threadDBHelper: Realm, ads: APIResponseObject){
        //store ads in realm db
        do{
            if(!isNilOrEmpty(ads.ads)){
            try threadDBHelper.write{
                for ad in ads.ads! {
                    OLXDatabseService.createObject(threadDBHelper, object: ad.toDBObject(ads.category_id!), update:true);
                }
            }
            }
        }catch let error as NSError{
            print("ERROR trying to write ads to DB: \(error)");
        }
    }
    
    static func fetchAds(threadDBHelper: Realm, category_id: String) -> Array<DBAd> {
        //fetch ads in realm db
        let predicate = NSPredicate(format:"category_id == %@", category_id);
        let Ads = threadDBHelper.objects(DBAd).filter(predicate).sorted("created", ascending: false);
        
        return OLXDatabseService.realmResutlsToArray(Ads);
    }

    //MARK: Helpers
    private static func createObject(threadDBHelper: Realm, object: Object, update: Bool){
        threadDBHelper.add(object, update: update)
    }
    
    private static func realmResutlsToArray<T>(results: Results<T>) -> [T] {
        var array = [T]();
        for i in 0 ..< results.count {
            array.append(results[i]);
        }
        return array;
    }
}