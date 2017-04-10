//
//  ViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit
import SafariServices

class AuthController: UIViewController, SFSafariViewControllerDelegate {
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

  var safari: SFSafariViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    if let authRequest = FacebookAPI.shared.buildAuthenticationRequest(),
//      let url = authRequest.url {
//      safari = SFSafariViewController(url: url)
//      safari.delegate = self
//    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    guard let safari = safari else { return }
    present(safari, animated: true, completion: nil)
  }

  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    loadingIndicator.stopAnimating()
  }
}

