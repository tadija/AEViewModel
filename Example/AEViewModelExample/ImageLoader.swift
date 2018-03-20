/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

class ImageLoader {
    
    // MARK: Singleton
    
    static let shared = ImageLoader()
    
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
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: cacheKey)
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

extension UIImage {
    static func load(from url: URL, completion: @escaping (UIImage?) -> Void) {
        ImageLoader.shared.loadImage(with: url, completion: completion)
    }
}

extension UIImageView {
    func loadImage(from url: URL, placeholer: UIImage? = nil, completion: (() -> Void)? = nil) {
        image = placeholer
        ImageLoader.shared.loadImage(with: url) { [weak self] (image) in
            self?.image = image
            completion?()
        }
    }
}
