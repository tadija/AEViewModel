/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel

struct GithubDataSource {
    struct Id {
        static let repo = "repo"
    }
    
    static func load(then handler: @escaping (BasicDataSource) -> Void) {
        fetchTrendingSwiftRepos { (repos) in
            let items = repos?.map { BasicItem(identifier: Id.repo, viewModel: $0) } ?? [BasicItem]()
            let section = BasicSection(items: items)
            let dataSource = BasicDataSource(title: "Github", sections: [section])
            DispatchQueue.main.async {
                handler(dataSource)
            }
        }
    }
    
    // MARK: Helpers
    
    private static func fetchTrendingSwiftRepos(then handler: @escaping ([Repo]?) -> Void) {
        URLSession.shared.dataTask(with: trendingSwiftReposURL) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let root = try? decoder.decode(GithubResponse.self, from: data)
                handler(root?.items)
            } else {
                handler(nil)
            }
        }.resume()
    }
    
    private static var trendingSwiftReposURL: URL {
        var components = URLComponents(string: "https://api.github.com/search/repositories")!
        components.queryItems = [
            URLQueryItem(name: "q", value: "pushed:>=\(lastWeekDate) language:swift"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc")
        ]
        let url = components.url!
        return url
    }
    
    private static var lastWeekDate: String {
        let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let date = df.string(from: lastWeekDate)
        return date
    }
}

// MARK: - Github Models

struct GithubResponse: Codable {
    let items: [Repo]
}

struct Repo: Codable {
    let name: String
    let description: String?
    let url: String
    let updated: Date
    let forksCount: Int
    let starsCount: Int
    let owner: Owner
    
    private enum CodingKeys: String, CodingKey {
        case name, description, url = "html_url", updated = "updated_at",
        forksCount = "forks_count", starsCount = "stargazers_count", owner
    }
}

struct Owner: Codable {
    let username: String
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case username = "login", avatarURL = "avatar_url"
    }
}

extension Repo: ViewModel {
    var ownerImageURL: URL? {
        let avatarURL = owner.avatarURL.replacingOccurrences(of: "?v=3", with: "")
        return URL(string: avatarURL)
    }
    var updatedFormatted: String {
        let df = Repo.dateFormatter
        df.dateStyle = .medium
        df.timeStyle = .short
        let date = df.string(from: updated)
        return date
    }
    private static let dateFormatter = DateFormatter()
}
