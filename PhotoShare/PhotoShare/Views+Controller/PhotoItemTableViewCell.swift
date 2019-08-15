//
//  PhotoItemTableViewCell.swift
//  PhotoShare
//
//  Created by Michael Moore on 8/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class PhotoItemTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likesImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var photo: PhotoObject? {
        didSet {
            updateViews()
        }
    }
   
    func updateViews() {
        guard let photo = photo else {
            likesLabel.text = ""
            photoImageView.image = nil
            return }
        
        likesLabel.text = "\(photo.likes)"
        
        PhotoController.fetchImage(image: photo) { (fetchedImage) in
            DispatchQueue.main.async {
                self.photoImageView.image = fetchedImage
            }
        }
    }
}
