//
//  AddListingViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let listing = Listing.testListing
        performSegue(withIdentifier: EditDetailsViewController.reuseID, sender: listing)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EditDetailsViewController.reuseID,
            let controller = segue.destination as? EditDetailsViewController,
            let listing = sender as? Listing {
            controller.listing = listing
            return
        }
    }
}
