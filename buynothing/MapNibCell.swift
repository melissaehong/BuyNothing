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

class MapNibCell: UITableViewCell {

    //setting up user location, pin and overlay

    @IBOutlet weak var mapView: MKMapView!

    var listing: Listing!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.mapView.delegate = self

    }

    func getCoordinate() -> CLLocationCoordinate2D {
        let latitude = self.listing.latitude
        let longitude = self.listing.longitude

        return CLLocationCoordinate2DMake(latitude!, longitude!)
    }

    func writeLocationToMap() {

        let listingLocation = self.getCoordinate()

        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)

        let region: MKCoordinateRegion = MKCoordinateRegionMake(listingLocation, span)

        mapView.setRegion(region, animated: true)

        self.mapView.showsUserLocation = true

//        let annotation = MKPointAnnotation()
//        annotation.coordinate = listingLocation
//        annotation.title = "Listing location"
//        mapView.addAnnotation(annotation)

         self.addRadiusCircle()
    }

    //circle radius
    func addRadiusCircle() {
        let circle = MKCircle(center: self.getCoordinate(), radius: 1_000 as CLLocationDistance)
        self.mapView.add(circle)
    }

}

// MARK: 

extension MapNibCell: MKMapViewDelegate {

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
