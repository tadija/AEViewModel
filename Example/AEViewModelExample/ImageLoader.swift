/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

extension UIImageView {
    func loadImage(from url: URL?, placeholer: UIImage? = nil, completion: (() -> Void)? = nil) {
        image = placeholer
        ImageLoader.shared.loadImage(with: url) { [weak self] (image) in
            self?.image = image
            completion?()
        }
    }
}

private class ImageLoader {
    static let shared = ImageLoader()
    private var cache = NSCache<NSString, UIImage>()
    
    func loadImage(with url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil); return
        }
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
