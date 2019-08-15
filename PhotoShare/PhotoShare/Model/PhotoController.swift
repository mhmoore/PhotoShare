//
//  PhotoController.swift
//  PhotoShare
//
//  Created by Michael Moore on 8/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation
import UIKit.UIImage


class PhotoController {
    
    static func fetchItem(searchTerm: String, completion: @escaping([PhotoObject]) -> Void){
         guard let baseURL = URL(string: "https://pixabay.com/api/") else { completion([]); return }
        let key = "13326155-cee75792af7778238ac8da9fc"
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let keyQueryItem = URLQueryItem(name: "key", value: key)
        let searchTermItem = URLQueryItem(name: "q", value: searchTerm)
        let typeQueryItem = URLQueryItem(name: "image_type", value: "photo")
        urlComponents?.queryItems = [keyQueryItem, searchTermItem, typeQueryItem]
        guard let finalURL = urlComponents?.url else { completion([]); return }
        print(finalURL.absoluteString)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error with the URLSession. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else { completion([]); return }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelPhotoDictionary.self, from: data)
                completion(topLevelDictionary.hits)
            } catch {
                print("Something went wrong with decoding. \(error): \(error.localizedDescription)")
                completion([])
                return
            }
        }.resume()
    }
    
    static func fetchImage(image: PhotoObject, completion: @escaping(UIImage?) -> Void ) {
        guard let imageURL = URL(string: image.imageURL ) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("There was an error getting the image. \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
