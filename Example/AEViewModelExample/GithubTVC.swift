/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import AEViewModel
import SafariServices

final class GithubTVC: TableViewController {

    // MARK: Properties

    var github: GithubDataSource? {
        return dataSource as? GithubDataSource
    }

    // MARK: Init
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = GithubDataSource()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
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
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        return .customNib(GithubRepoCell.self)
    }

    override func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {
        if let repo = dataSource
            .viewModel(at: indexPath) as? Repo, let url = URL(string: repo.url) {
            let browser = SFSafariViewController(url: url)
            browser.title = title
            present(browser, animated: true, completion: nil)
        }
    }
    
    // MARK: Helpers

    private func performManualRefresh() {
        if let refreshControl = refreshControl {
            tableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
            refreshControl.beginRefreshing()
            refresh(refreshControl)
        }
    }
    
    @objc
    private func refresh(_ sender: UIRefreshControl) {
        github?.reload() { [weak self] (viewModel) in
            sender.endRefreshing()
            self?.dataSource = viewModel
        }
    }
    
}
