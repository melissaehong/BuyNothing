//
//  User.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

struct User {
  let emailAddress: String
  let facebookID: String
  let firstName: String
  let lastInitial: String
  var latitude: Float?
  var longitude: Float?

  init?(json: [String: AnyObject]) {
    guard let emailAddress = json["email"] as? String,
      let facebookID = json["id"] as? String,
      let firstName = json["first_name"] as? String,
      let lastInitial = json["last_name"] as? String
      else { return nil }
      
    self.emailAddress = emailAddress
    self.facebookID = facebookID
    self.firstName = firstName
    self.lastInitial = lastInitial
  }
}
