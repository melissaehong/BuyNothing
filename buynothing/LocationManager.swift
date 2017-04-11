//
//  LocationManager.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, MKMapViewDelegate {
    
    let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    
    override init(){
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 1000
        
        self.requestPermission()
        
    }
    
    func requestPermission() {
        if ((CLLocationManager.authorizationStatus() == CLAuthorizationStatus.restricted) || (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied)) {
            
            print("Location Authorization denied")
            
            self.manager.requestWhenInUseAuthorization()
            
        } else {
            print("Location Services enabled")
            CLLocationManager.locationServicesEnabled()
        }
    }
    
    func getLocation() -> CLLocation? {
        self.manager.requestLocation()
        if let location = self.manager.location {
            return location
        }
        return nil
    }
   
    
}


//EXTENSION: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}













