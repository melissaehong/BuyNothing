//
//  Listing.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CloudKit
import Foundation

struct Listing {
    let user: User
    let createdAt: Date
    let duration: Int
    var descriptionText: String
    var title: String
    var latitude: Float?
    var longitude: Float?

    static var testListing: Listing {
        var listing = Listing(user: User.testUser,
                              descriptionText: "a listing",
                              createdAt: "2017-01-01",
                              duration: 7,
                              title: "This is a title")!
        listing.latitude = 47.606_209
        listing.longitude = -122.332_071
        return listing
    }

    init?(user: User, descriptionText: String, createdAt: String, duration: Int, title: String) {
        guard let createdAtDate = Date.fromString(createdAt)
            else { return nil }

        self.user = user
        self.createdAt = createdAtDate
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
            return record
        } else {
            return nil
        }
    }
}
