//
//  Listing.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CloudKit
import Foundation

typealias ListingCompletion = (Listing?) -> Void

struct Listing {
    let user: User
    let createdAt: Date
    let duration: Int
    var descriptionText: String
    var title: String
    var latitude: Float?
    var longitude: Float?

    static var testListing: Listing {
        let createdAtDate = Date.fromString("2017-01-01")

        var listing = Listing(user: User.testUser,
                              descriptionText: "Yo nobody in my hood got one.",
                              createdAt: createdAtDate!,
                              duration: 7,
                              title: "Datsun Z28")!
        listing.latitude = 47.606_209
        listing.longitude = -122.332_071
        return listing
    }

    init?(user: User, descriptionText: String, createdAt: Date, duration: Int, title: String) {

        self.createdAt = createdAt
        self.user = user
        self.duration = duration
        self.descriptionText = descriptionText
        self.title = title
    }

    static func listAll(completion: @escaping ListingCompletion) {
        CloudKitFacade.shared.getListings { (record) in
            guard let record = record else { return }
            let listing = Listing(user: User.testUser,
                                  descriptionText: record["descriptionText"] as! String,
                                  createdAt: record["createdAt"] as! Date,
                                  duration: record["duration"] as! Int,
                                  title: (record["title"] as? String) ?? "")
            completion(listing)
        }
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
