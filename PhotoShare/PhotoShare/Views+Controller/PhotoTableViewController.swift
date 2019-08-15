//
//  PhotoTableViewController.swift
//  PhotoShare
//
//  Created by Michael Moore on 8/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController, UISearchBarDelegate {
    // MARK: - Outlets
    @IBOutlet weak var photoSearchBar: UISearchBar!
    
    // MARK: - Properties
    var photos: [PhotoObject] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoItemTableViewCell
        let photoItem = photos[indexPath.row]
        cell.photo = photoItem
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PhotoController.fetchItem(searchTerm: searchTerm) { (photos) in
            self.photos = photos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
