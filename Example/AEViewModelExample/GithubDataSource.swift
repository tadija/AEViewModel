//
//  GithubDataSource.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation

final class GithubDataSource {
    
    // MARK: Properties
    
    private let github = Github()
    
    private lazy var trendingSwiftReposURL: URL = {
        let url = Github.API.url(.search("repositories")).addingParameters([
            "q" : "language:swift created:\(lastWeekDate)",
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
                let response = try closure()
                if let items = response["items"] as? [Any] {
                    let repos: [Repo] = try items.mappableArray()
                    completion(repos)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
}
