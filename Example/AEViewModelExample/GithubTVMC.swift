//
//  GithubTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel
import SafariServices

final class GithubTVMC: TableViewModelController {
    
    typealias CellType = BasicTable.GithubCellType
    
    // MARK: Properties
    
    private let dataSource = GithubDataSource()
    
    private var repos = [Repo]() {
        didSet {
            let items = repos.map { BasicItem(identifier: CellType.repo.rawValue, data: $0) }
            let section = BasicSection(items: items)
            let table = BasicTable(sections: [section])
            model = table
        }
    }
    
    func repo(at indexPath: IndexPath) -> Repo? {
        let repo = item(at: indexPath)?.data as? Repo
        return repo
    }
    
    // MARK: Init
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
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
    
    private func configureSelf() {
        title = "Github"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc
    private func refresh(_ sender: UIRefreshControl) {
        dataSource.reload { [weak self] (repos) in
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
            if let repos = repos {
                self?.repos = repos
            }
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
