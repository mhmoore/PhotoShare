//
//  Photo.swift
//  PhotoShare
//
//  Created by Michael Moore on 8/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

struct TopLevelPhotoDictionary: Codable {
    
    let hits: [PhotoObject]
}

struct PhotoObject: Codable {
    
    let tags: String
    let imageURL: String
    let likes: Int
    
    private enum CodingKeys: String, CodingKey {
        case tags
        case likes
        case imageURL = "largeImageURL"
    }
}
