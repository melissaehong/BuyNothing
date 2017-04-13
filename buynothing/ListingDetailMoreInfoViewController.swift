//
//  ListingDetailMoreInfoController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ListingDetailMoreInfoViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    var selectedListing: Listing! = Listing.testListing

    // TEMPORARY
    let listingLocation = CLLocationCoordinate2DMake(47.606209, -122.332071)

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        LocationManager.shared.requestPermission()

        if (selectedListing) != nil {
            self.titleLabel.text = self.selectedListing.title
            self.descriptionLabel.text = self.selectedListing.descriptionText
            self.categoryLabel.text = "No Category Selected"
            self.locationLabel.text = "Location"
        }

        // TEMPORARY
//        selectedListing = Listing.testListing
    }

    override func viewDidAppear(_ animated: Bool) {
        writeLocationToMap()
    }

    func writeLocationToMap() {
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(listingLocation, span)
        let circle = MKCircle(center: listingLocation, radius: 1_000 as CLLocationDistance)

        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.add(circle)
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: MapViewDelegate
extension ListingDetailMoreInfoViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = UIColor.red
        circle.fillColor = UIColor(red: 250, green: 0, blue: 0, alpha: 0.1)
        circle.lineWidth = 1
        return circle
    }
}
