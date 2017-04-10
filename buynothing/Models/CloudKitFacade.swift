//
//  CloudKitFacade.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CloudKit

typealias SuccessCompletion = (Bool) -> Void
typealias RecordCompletion = (CKRecord?) -> Void
typealias CollectionCompletion = ([CKRecord]?) -> Void

struct CloudKitFacade {
  static let shared = CloudKitFacade()
  private init() {}

  let container = CKContainer.default()

  var publicDatabase: CKDatabase {
    return container.publicCloudDatabase
  }

  /// Save LISTING to CloudKit public database,
  /// yield success boolean to COMPLETION handler.
  func saveListing(_ listing: Listing, completion: @escaping SuccessCompletion) {
    let completeInMain = {(success: Bool) -> Void in
      OperationQueue.main.addOperation { completion(success) }
    }

    OperationQueue().addOperation {
      do {
        if let record = try listing.toRecord() {
          self.publicDatabase.save(record) { (record, error) in
            // TODO: Add error handling
            guard error == nil, record != nil else { return completeInMain(false) }
            return completeInMain(true)
          }
        }
      } catch {
        // Add error handling for record not being created
        return completeInMain(false)
      }
    }
  }

  /// getAll
}

