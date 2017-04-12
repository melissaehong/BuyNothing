//
//  HomeViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

// TODO: 
// - Implement Search
// - Implement pull to refresh
// - Paginate results of queries

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var allListings = [Listing]() {
        didSet { collectionView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        collectionView.delegate = self
        collectionView.dataSource = self

        let listingCell = UINib(nibName: ListingCell.reuseID, bundle: nil)
        collectionView.register(listingCell, forCellWithReuseIdentifier: ListingCell.reuseID)
        collectionView.collectionViewLayout = GalleryViewLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        loadingIndicator.startAnimating()

        Listing.listAll { (listings) in
            guard let listings = listings else { return }

            if listings.isEmpty {
                print("no results")
                // TODO: let the user know the query returned no results
            }

            self.allListings = listings
            self.loadingIndicator.stopAnimating()
        }
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
        print("searchBarTextDidEndEditing")
    }
}
