//
//  ListingDetailViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {
    var listing: Listing!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = listing.image
        listingTitle.text = listing.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func closeButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
