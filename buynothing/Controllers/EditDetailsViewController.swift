//
//  EditDetailsViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController {
    @IBOutlet weak var listingTitle: UITextField!
    @IBOutlet weak var listingDescription: UITextField!

    var listing: Listing!

    override func viewDidLoad() {
        super.viewDidLoad()
        listingTitle.text = listing.title
        listingDescription.text = listing.descriptionText
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        listing.title = listingTitle.text ?? ""
        listing.descriptionText = listingDescription.text ?? ""

        CloudKitFacade.shared.saveListing(listing) { (success) in
            if success {
                print("posted to cloudkit")
                // TODO: prompt user
            } else {
                print("didn't work :(")
                // TODO: prompt user
            }
        }
    }
}
