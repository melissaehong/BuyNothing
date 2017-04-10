//
//  HomeViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  var listings = [Listing]() {
    didSet {
      collectionView.reloadData()
    }
  }

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    collectionView.delegate = self
    collectionView.dataSource = self
    searchBar.delegate = self

    let user = User(json: [
      "email": "juner@gmail.com" as AnyObject,
      "id": "39393" as AnyObject,
      "first_name": "June" as AnyObject,
      "last_name": "R" as AnyObject
      ])
    listings = [
      Listing(user: user!,
              descriptionText: "a listing",
              createdAt: "2017-01-01",
              duration: 7)
    ]
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listings.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCell", for: indexPath)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("selected \(indexPath.row)")
  }
}

extension HomeViewController: UISearchBarDelegate {
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    print("ended editing")
  }
}
