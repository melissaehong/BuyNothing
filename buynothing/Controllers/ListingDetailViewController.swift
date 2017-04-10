//
//  ListingDetailViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ListingDetailViewController: UIViewController  {
  @IBOutlet weak var mapView: MKMapView!
  
  let listing = (latitude: 47.606209, longitude: -122.332071)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var coordinates = CLLocationCoordinate2D()
    coordinates.latitude = listing.latitude
    coordinates.longitude = listing.longitude
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinates
    mapView.addAnnotation(annotation)
  }
}
