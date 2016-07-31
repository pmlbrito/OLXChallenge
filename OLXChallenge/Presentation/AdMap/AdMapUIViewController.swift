//
//  AdMapUIViewController.swift
//  OLXChallenge
//
//  Created by Pedro Brito on 31/07/16.
//  Copyright © 2016 Pedro Brito. All rights reserved.
//

import UIKit
import MapKit
import QuickShotUtils

class AdMapUIViewController : UIViewController {
    
    @IBOutlet var locationMap: MKMapView!
    
    var adItem: AdViewModel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.setViewValues();
        
        self.locationMap.zoomEnabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDetailViewData(viewModel: AdViewModel){
        self.adItem = viewModel;
    }
    
    func setViewValues(){
        let initialLocation = CLLocation(latitude: (adItem.map_lat! as NSString).doubleValue, longitude: (adItem.map_lon! as NSString).doubleValue)
        
        self.centerMapOnLocation(initialLocation);
        
        //add anotation with pin
        let itemAnnotation = OLXMapLocationMKAnnotation(title: adItem.title!,
                                                        username: String(format:"%@ - %@", adItem.user_label!, !isNilOrEmpty(adItem.price_numeric) ? String(format:"%@ €", adItem.price_numeric!) : ""),
                              coordinate: initialLocation.coordinate)
        
        locationMap.addAnnotation(itemAnnotation)
    }
    
    
    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        locationMap.setRegion(coordinateRegion, animated: true)
    }
}

extension AdMapUIViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? OLXMapLocationMKAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
                //view.calloutOffset = CGPoint(x: -5, y: 5)
                //view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}