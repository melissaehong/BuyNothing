//
//  HomeViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    var allListings = [Listing]() {
        didSet { collectionView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self

        allListings = [Listing.testListing]

        let listingCell = UINib(nibName: ListingCell.reuseID, bundle: nil)
        collectionView.register(listingCell, forCellWithReuseIdentifier: ListingCell.reuseID)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ListingDetailViewController.reuseID,
            let controller = segue.destination as? ListingDetailViewController,
            let selectedListing = sender as? Listing {
            controller.listing = selectedListing
            return
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allListings.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCell.reuseID, for: indexPath) as! ListingCell
        cell.listing = allListings[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = allListings[indexPath.row]
        performSegue(withIdentifier: ListingDetailViewController.reuseID, sender: selectedCell)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("ended editing")
    }
}
