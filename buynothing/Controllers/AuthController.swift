//
//  ViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

class AuthController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if FBSDKAccessToken.current() != nil {
            performSegue(withIdentifier: UITabBarController.reuseID, sender: nil)
        } else {
            let facebookLoginButton = FBSDKLoginButton()
            facebookLoginButton.center = self.view.center
            view.addSubview(facebookLoginButton)
        }
    }
}
