//
//  MapNibCell.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapNibCell: UITableViewCell, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //setting up user location, pin and overlay
    
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    var locations: [CLLocation] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
//        addRadiusCircle(userLocation: CLLocation)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation
        annotation.title = "Listing location"
        map.addAnnotation(annotation)
        
    }
    
    //circle radius
    func addRadiusCircle(userLocation: CLLocation) {
        self.map.delegate = self
        let circle = MKCircle(center: userLocation.coordinate, radius: 1000 as CLLocationDistance)
        self.map.add(circle)
    }
    
    //draw circle radius
    func mapView(map: MKMapView!, renderForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 250, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
    
    
}
