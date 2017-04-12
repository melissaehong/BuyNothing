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
    var duration: Int = 7
    var isActive: Bool = true
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
                guard let asset = record["image"] as? CKAsset,
                    let imageData = NSData(contentsOf: asset.fileURL),
                    let image = UIImage(data: imageData as Data)
                    else { continue }

                var listing = Listing(user: User.testUser,
                                      descriptionText: record["descriptionText"] as? String ?? "",
                                      duration: record["duration"] as? Int ?? 7,
                                      title: record["title"] as? String ?? "")

                listing.createdAt = record.creationDate
                listing.image = image

                let activeEnum = record["is_active"] as? Int
                listing.isActive = (activeEnum != 0)

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
    }

    /// Generate a CKRecord representation of listing to allow
    /// persisting to CloudKit
    func toRecord() throws -> CKRecord? {
        guard let descriptionText = descriptionText,
            let user = user,
            let image = image,
            let title = title,
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            else { return nil }

        do {
            try imageData.write(to: image.path)
            let asset = CKAsset(fileURL: image.path)

            let record = CKRecord(recordType: "Listings")
            record["descriptionText"] = descriptionText as CKRecordValue
            record["title"] = title as CKRecordValue
            record["duration"] = duration as CKRecordValue
            record["isActive"] = isActive as CKRecordValue

            record["image"] = asset
            guard let userRecord = user.toRecord() else { return nil }
            record["user"] = CKReference(record: userRecord, action: .none)
            return record
        } catch {
            return nil
        }
    }
}
