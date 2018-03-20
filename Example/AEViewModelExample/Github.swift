/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation
import Network

final class Github {
    
    struct API {
        static let base = "https://api.github.com"
        
        enum Endpoint {
            case search(String)
        }
        
        static func url(_ endpoint: Endpoint) -> URL {
            var url = URL(string: API.base)!
            switch endpoint {
            case .search(let path):
                let path = "search/\(path)"
                url.appendPathComponent(path)
            }
            return url
        }
    }
    
    private let network = Network()

    func fetch(from url: URL, completion: @escaping Network.Completion.ThrowableData) {
        let request = URLRequest(url: url)
        network.fetchData(with: request, completion: completion)
    }

}
