/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import AEViewModel
import SafariServices

final class GithubTVMC: TableViewModelController {
    
    // MARK: Properties
    
    private let github = GithubDataSource()

    // MARK: Init
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Github"

        tableView.rowHeight = UITableViewAutomaticDimension
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
    
    // MARK: TableViewModelControllerDelegate
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .customNib(nib: GithubRepoCell.nib)
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: TableViewModelController) {
        if let repo = dataSource.viewModel(at: indexPath) as? Repo, let url = URL(string: repo.url) {
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
        github.reload { [weak self] (repos) in
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
            if let repos = repos {
                let items = repos.map { BasicItem(identifier: GithubRepoCell.reuseIdentifier, viewModel: $0) }
                let section = BasicSection(items: items)
                self?.dataSource = BasicDataSource(sections: [section])
            }
        }
    }
    
}
