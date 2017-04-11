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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EditDetailsViewController.reuseID,
            let controller = segue.destination as? EditDetailsViewController,
            let listing = sender as? Listing {
            controller.listing = listing
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let user = User(json: [
            "email": "juner@gmail.com" as AnyObject,
            "id": 39393 as AnyObject,
            "first_name": "June" as AnyObject,
            "last_name": "R" as AnyObject
            ])
        let listing = Listing(user: user!,
                              descriptionText: "a listing",
                              createdAt: "2017-01-01",
                              duration: 7, title: "This is the title")
        
        performSegue(withIdentifier: EditDetailsViewController.reuseID, sender: listing)
    }
    
}




