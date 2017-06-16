//
//  GithubTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

extension Repo: ItemData {
    var title: String? {
        return name
    }
    var detail: String? {
        return description
    }
}

final class GithubTVMC: TableViewModelController {
    
    typealias GithubItem = GithubTable.ItemType
    
    // MARK: Properties
    
    private let dataSource = GithubDataSource()
    
    private var repos = [Repo]() {
        didSet {
            let items = repos.map { BasicItem(identifier: GithubItem.repo.rawValue, data: $0) }
            let section = BasicSection(items: items)
            var table = GithubTable()
            table.sections = [section]
            model = table
        }
    }
    
    // MARK: Init
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performManualRefresh()
    }
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
    }
    
    // MARK: Helpers
    
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
