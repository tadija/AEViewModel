//
//  GithubTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel
import SafariServices

extension Repo: ItemData {
    var ownerImageURL: URL? {
        let avatarURL = owner.avatarURL.replacingOccurrences(of: "?v=3", with: "")
        return URL(string: avatarURL)
    }
}

final class GithubTVMC: TableViewModelController {
    
    typealias GithubItem = BasicTable.GithubItemType
    
    // MARK: Properties
    
    private let dataSource = GithubDataSource()
    
    private var repos = [Repo]() {
        didSet {
            let items = repos.map { BasicItem(identifier: GithubItem.repo.rawValue, data: $0) }
            let section = BasicSection(items: items)
            let table = BasicTable(title: "Github", sections: [section])
            model = table
        }
    }
    
    func repo(at indexPath: IndexPath) -> Repo? {
        let repo = model?.item(at: indexPath)?.data as? Repo
        return repo
    }
    
    // MARK: Init
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    private var initialAppear = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if initialAppear {
            initialAppear = false
            performManualRefresh()
        }
    }
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .customNib(nib: GithubRepoCell.nib)
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)
        
        cell.action = { _ in
            if let repo = self.repo(at: indexPath), let url = URL(string: repo.url) {
                self.pushBrowser(with: url, title: repo.name)
            }
        }
    }
    
    // MARK: Helpers
    
    private func pushBrowser(with url: URL, title: String? = nil) {
        let browser = SFSafariViewController(url: url)
        browser.title = title
        navigationController?.pushViewController(browser, animated: true)
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc
    private func refresh(_ sender: UIRefreshControl) {
        dataSource.reload { (repos) in
            if let repos = repos {
                self.repos = repos
            }
            sender.endRefreshing()
        }
    }
    
    private func performManualRefresh() {
        if let refreshControl = refreshControl {
            tableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
            refreshControl.beginRefreshing()
            refresh(refreshControl)
        }
    }
    
}
