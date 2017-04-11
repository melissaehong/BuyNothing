//
//  EditDetailsViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listingTitle.text = listing.title
        listingDescription.text = listing.descriptionText
        
    }
    
    
    @IBOutlet weak var listingTitle: UITextField!
    
    @IBOutlet weak var listingDescription: UITextField!
    
    
    var listing: Listing!
    
    
    
    
}
