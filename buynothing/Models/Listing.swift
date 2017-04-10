//
//  Listing.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

struct Listing {
  let user: User
  let createdAt: Date
  let duration: Int
  let descriptionText: String
  
  init(user: User, descriptionText: String, createdAt: String, duration: Int) {
    self.user = user
    self.createdAt = Date.fromString(createdAt)!
    self.duration = duration
    self.descriptionText = descriptionText
  }
}

