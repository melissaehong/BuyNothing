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
    
    if (FBSDKAccessToken.current() != nil) {
        print("Access token success")
    } else {
        let facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.center = self.view.center
        view.addSubview(facebookLoginButton)
    }
  }
}

