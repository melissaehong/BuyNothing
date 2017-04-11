//
//  ListingDetailViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class ListingDetailViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    let listing = Listing.testListing

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotation = MKPointAnnotation()
        var coordinate: CLLocationCoordinate2D

        if let latitude = listing.latitude, let longitude = listing.longitude {
            coordinate = CLLocationCoordinate2D()
            coordinate.latitude = CLLocationDegrees(latitude)
            coordinate.longitude = CLLocationDegrees(longitude)
            annotation.coordinate = coordinate
        }

        mapView.addAnnotation(annotation)
    }
}
