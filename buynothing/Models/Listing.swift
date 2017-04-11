//
//  Listing.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation
import CloudKit

struct Listing {
    let user: User
    let createdAt: Date
    let duration: Int
    let descriptionText: String
    let title: String
    
    init(user: User, descriptionText: String, createdAt: String, duration: Int, title: String) {
        self.user = user
        self.createdAt = Date.fromString(createdAt)!
        self.duration = duration
        self.descriptionText = descriptionText
        self.title = title
    }
    
    /// Generate a CKRecord representation of listing to allow
    /// persisting to CloudKit
    func toRecord() throws -> CKRecord? {
        let record = CKRecord(recordType: "Listings")
        
        record["createdAt"] = createdAt as CKRecordValue
        record["descriptionText"] = descriptionText as CKRecordValue
        record["duration"] = duration as CKRecordValue
        
        if let userRecord = user.toRecord() {
            record["user"] = CKReference(record: userRecord, action: .none)
        }
        
        return record
    }
}

