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


    @IBOutlet weak var mapContainerView: UIView!
    
    @IBOutlet weak var conditionSlider: UISlider!
    @IBOutlet weak var usedCondition: UILabel!
    @IBOutlet weak var normalCondition: UILabel!
    @IBOutlet weak var excellentCondition: UILabel!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {

        var currentValue = Int(sender.value)
        
        usedCondition.text = "\(currentValue)"
        normalCondition.text = "\(currentValue)"
        excellentCondition.text = "\(currentValue)"
    }
    
    
    
    var listing: Listing!
    
    let mapNibView = Bundle.main.loadNibNamed("MapNibCell", owner: self, options: nil)?.first as? UIView

    override func viewDidLoad() {
        super.viewDidLoad()
        listingTitle.text = listing.title
        listingDescription.text = listing.descriptionText
        
        self.mapContainerView.addSubview(mapNibView!)
      

        
        //        self.mapContainerView.register(mapNibCell, forCellReuseIdentifier: MapNibCell.identifier)
//        
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
