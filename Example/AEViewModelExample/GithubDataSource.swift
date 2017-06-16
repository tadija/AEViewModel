//
//  GithubDataSource.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import Foundation

final class GithubDataSource {
    
    private let github = Github()
    
    private lazy var trendingSwiftReposURL: URL = {
        let url = Github.API.url(.search("repositories")).addingParameters([
            "q" : "language:swift created:2017-06-14",
            "sort" : "stars",
            "order" : "desc"
        ])!
        return url
    }()
    
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
