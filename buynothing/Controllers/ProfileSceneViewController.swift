//
//  ProfileSceneViewController.swift
//  buynothing
//
//  Created by A Cahn on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class ProfileSceneViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        let profileVC = Bundle.main.loadNibNamed(ProfileSceneViewController.reuseID, owner: self, options: nil)?.first as! ProfileSceneViewController
        present(profileVC, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
