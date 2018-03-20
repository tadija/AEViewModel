/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

final class GithubDataSource {
    
    // MARK: Properties
    
    private let github = Github()
    
    private lazy var trendingSwiftReposURL: URL = {
        let url = Github.API.url(.search("repositories")).addingParameters([
            "q" : "pushed:>=\(GithubDataSource.lastWeekDate) language:swift",
            "sort" : "stars",
            "order" : "desc"
        ])!
        return url
    }()
    
    private static var lastWeekDate: String {
        let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: lastWeekDate)
        return date
    }
    
    // MARK: API
    
    func reload(completion: @escaping ([Repo]?) -> Void) {
        github.fetch(from: trendingSwiftReposURL) { closure in
            do {
                let data = try closure()
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let root = try decoder.decode(Root.self, from: data)
                completion(root.items)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
}
