/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel
import SafariServices

final class GithubTVMC: TableViewModelController {
    
    typealias CellType = BasicDataSource.GithubCellType
    
    // MARK: Properties
    
    private let github = GithubDataSource()
    
    private var repos = [Repo]() {
        didSet {
            let items = repos.map { BasicItem(identifier: CellType.repo.rawValue, model: $0) }
            let section = BasicSection(items: items)
            dataSource = BasicDataSource(sections: [section])
        }
    }
    
    func repo(at indexPath: IndexPath) -> Repo? {
        return dataSource.item(at: indexPath).model as? Repo
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
    
    override func update(_ cell: UITableViewCell & TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        
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
        present(browser, animated: true, completion: nil)
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
        github.reload { [weak self] (repos) in
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
