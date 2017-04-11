//
//  ViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class AuthController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.current() != nil) {
//            print("Access token success")
            performSegue(withIdentifier: "TabBarController", sender: nil)
        } else {
            let facebookLoginButton = FBSDKLoginButton()
            facebookLoginButton.center = self.view.center
            view.addSubview(facebookLoginButton)
        }
    }
    
    //take view off parent view, and parent viewcontroller
    func dismissAuthController() {
        
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        
    }
}
