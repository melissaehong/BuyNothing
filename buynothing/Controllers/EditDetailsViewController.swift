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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        print("button pressed")
        listing.title = listingTitle.text ?? ""
        listing.descriptionText = listingDescription.text ?? ""
        
        CloudKitFacade.shared.saveListing(listing, completion: { (success) in
            print("cloudkit save listing")
            if success {
                print("posted to cloudkit")
            } else {
                print("didn't work :(")
            }
        })
    }
    
    
    var listing: Listing!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listingTitle.text = listing.title
        listingDescription.text = listing.descriptionText
    }
}
