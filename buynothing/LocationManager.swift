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

class LocationManager: NSObject {
    static let shared = LocationManager()
    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 1_000
    }

    func requestPermission() {
        print("requestPermission")
        let authStatus = CLLocationManager.authorizationStatus()
        let authIsRestricted = authStatus == CLAuthorizationStatus.restricted
        let authIsDenied = authStatus == CLAuthorizationStatus.denied

        if authIsRestricted || authIsDenied {
            print("Location authorization restricted or denied")
            manager.requestWhenInUseAuthorization()
        } else {
            print("Location services enabled")
            CLLocationManager.locationServicesEnabled()
            manager.requestLocation()
        }
    }
}

// MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        debugPrint(locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
