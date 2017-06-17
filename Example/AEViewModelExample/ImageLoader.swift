//
//  ImageLoader.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit

class ImageLoader {
    
    // MARK: Properties

    private var cache = NSCache<NSString, UIImage>()
    
    // MARK: API
    
    func loadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.absoluteString as NSString
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: cacheKey)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }).resume()
        }
    }
    
}
