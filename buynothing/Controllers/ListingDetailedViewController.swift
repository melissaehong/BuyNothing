//
//  ListingDetailedViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ListingDetailedViewController: UIViewController  {

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude: CLLocationDegrees?
    var longtitude: CLLocationDegrees?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        
        var coordinates = CLLocationCoordinate2D()
        
        coordinates.latitude = 47.606209
        coordinates.longitude = -122.332071
    
        annotation.coordinate = coordinates
        
        mapView.addAnnotation(annotation)
        

    }
    



}
