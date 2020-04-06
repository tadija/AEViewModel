/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import UIKit

open class CollectionViewController: UICollectionViewController, CellDelegate {

    // MARK: Properties

    open var isAutomaticReloadEnabled = true

    open var dataSource: DataSource = BasicDataSource() {
        didSet {
            if isAutomaticReloadEnabled {
                reload()
            }
        }
    }

    // MARK: Init

    public convenience init() {
        self.init(dataSource: BasicDataSource())
    }

    public convenience init(dataSource: DataSource,
                            layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.init(collectionViewLayout: layout)
        self.dataSource = dataSource
    }

    // MARK: Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    // MARK: API

    open func cellType(forIdentifier identifier: String) -> CollectionCellType {
        return .basic
    }

    open func update(_ cell: CollectionCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)
        cell.delegate = self
    }

    open func action(for cell: CollectionCell, at indexPath: IndexPath, sender: Any) {}

    // MARK: CellDelegate

    public func callback(from cell: Cell, sender: Any) {
        if let cell = cell as? CollectionCell,
            let indexPath = collectionView?.indexPath(for: cell) {
            action(for: cell, at: indexPath, sender: sender)
        }
    }

    // MARK: Helpers

    private func reload() {
        if Thread.isMainThread {
            performReload()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.performReload()
            }
        }
    }

    private func performReload() {
        if let title = dataSource.title {
            self.title = title
        }
        collectionView?.reloadData()
    }

}

// MARK: - UICollectionViewControllerDataSource

extension CollectionViewController {

    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }

    open override func collectionView(_ collectionView: UICollectionView,
                                      numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }

    open override func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = dataSource.identifier(at: indexPath)
        registerCell(with: id)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        if let cell = cell as? CollectionCell {
            update(cell, at: indexPath)
        }
        return cell
    }

    // MARK: Helpers

    private func registerCell(with identifier: String) {
        switch cellType(forIdentifier: identifier) {
        case .basic:
            collectionView?.register(
                CollectionCellBasic.self,
                forCellWithReuseIdentifier: identifier
            )
        case .button:
            collectionView?.register(
                CollectionCellButton.self,
                forCellWithReuseIdentifier: identifier
            )
        case .spinner:
            collectionView?.register(
                CollectionCellSpinner.self,
                forCellWithReuseIdentifier: identifier
            )
        case .customClass(let cellClass):
            collectionView?.register(
                cellClass,
                forCellWithReuseIdentifier: identifier
            )
        case .customNib(let cellClass):
            collectionView?.register(
                cellClass.nib,
                forCellWithReuseIdentifier: identifier
            )
        }
    }

}

// MARK: - UICollectionViewControllerDelegate

extension CollectionViewController {

    open override func collectionView(_ collectionView: UICollectionView,
                                      didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionCell
            else {
                return
        }
        action(for: cell, at: indexPath, sender: self)
    }

}
