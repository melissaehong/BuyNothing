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
    var user: User?
    var duration: Int?
    var descriptionText: String?
    var title: String?
    var latitude: Double?
    var longitude: Double?
    var createdAt: Date?
    var image: UIImage?

    static var testListing: Listing {
        var listing = Listing(user: User.testUser,
                              descriptionText: "Yo nobody in my hood got one.",
                              duration: 7,
                              title: "Datsun Z28")
        listing.createdAt = Date.fromString("2017/01/01")
        listing.latitude = 47.606_209
        listing.longitude = -122.332_071
        return listing
    }

    /// Fetch all Listings available on CloudKit and yield the array of listings
    /// to the Completion handler on the main queue.
    static func listAll(completion: @escaping ListingCompletion) {
        CloudKitFacade.shared.getListings { (records) in

            guard let records = records else { return }
            for record in records {
                var listing = Listing(user: User.testUser,
                                      descriptionText: record["descriptionText"] as? String ?? "",
                                      duration: record["duration"] as? Int ?? 0,
                                      title: record["title"] as? String ?? "")
                listing.createdAt = record.creationDate
                completion(listing)
            }
        }
    }

    init() { }

    init(user: User, descriptionText: String, duration: Int, title: String) {
        self.user = user
        self.duration = duration
        self.descriptionText = descriptionText
        self.title = title

        if let location = LocationManager.shared.getLocation() {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }

    /// Generate a CKRecord representation of listing to allow
    /// persisting to CloudKit
    func toRecord() throws -> CKRecord? {
        guard let createdAt = createdAt,
            let descriptionText = descriptionText,
            let duration = duration,
            let user = user
            else { return nil }

        let record = CKRecord(recordType: "Listings")
        record["createdAt"] = createdAt as CKRecordValue
        record["descriptionText"] = descriptionText as CKRecordValue
        record["duration"] = duration as CKRecordValue

        guard let userRecord = user.toRecord() else { return nil }
        record["user"] = CKReference(record: userRecord, action: .none)
        return record
    }
}
