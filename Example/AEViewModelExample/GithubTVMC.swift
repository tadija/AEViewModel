//
//  GithubTVMC.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/17/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

final class GithubTVMC: TableViewModelController {
    
    typealias GithubItem = GithubTable.ItemType
    
    // MARK: Properties
    
    private let dataSource = GithubDataSource()
    
    private var repos = [Repo]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let refreshControl = refreshControl {
            tableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
            refreshControl.beginRefreshing()
            refresh(refreshControl)
        }
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
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        return .subtitle
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath, with item: Item) {
        super.configureCell(cell, at: indexPath, with: item)
    }
    
}
