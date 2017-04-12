//
//  AddListingViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController {
    var imagePicker = UIImagePickerController()
    var newListing: Listing?
    var imagePickCancelled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePicker()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !imagePickCancelled else {
            imagePickCancelled = false
            tabBarController?.selectedIndex = 0
            return
        }

        if let newListing = newListing {
            performSegue(withIdentifier: EditDetailsViewController.reuseID, sender: newListing)
        } else {
            present(imagePicker, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EditDetailsViewController.reuseID,
            let controller = segue.destination as? EditDetailsViewController,
            let listing = sender as? Listing {
            controller.listing = listing
            return
        }
    }
}

extension AddListingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.newListing = Listing()
        guard var newListing = newListing else { return }

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            newListing.image = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newListing.image = image
        }

        imagePicker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickCancelled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
