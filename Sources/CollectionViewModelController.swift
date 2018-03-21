/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class CollectionViewModelController: UICollectionViewController {
    
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
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    public convenience init(collectionViewLayout layout: UICollectionViewLayout, dataSource: DataSource) {
        self.init(collectionViewLayout: layout)
        self.dataSource = dataSource
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    // MARK: Abstract
    
    open func cell(forIdentifier identifier: String) -> CollectionCell {
        return .empty
    }
    
    open func configureCell(_ cell: UICollectionViewCell & CollectionViewModelCell, at indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        cell.update(with: item)
    }
    
    // MARK: Helpers
    
    private func reload() {
        if Thread.isMainThread {
            registerCellsAndReloadDataIfNeeded()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.registerCellsAndReloadDataIfNeeded()
            }
        }
    }
    
    private func registerCellsAndReloadDataIfNeeded() {
        registerCells()
        collectionView?.reloadData()
    }
    
    private func registerCells() {
        dataSource.uniqueIdentifiers.forEach { identifier in
            registerCell(with: identifier)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cell(forIdentifier: identifier) {
        case .empty:
            collectionView?.register(CollectionCellEmpty.self, forCellWithReuseIdentifier: identifier)
        case .customClass(let cellClass):
            collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
        case .customNib(let cellNib):
            collectionView?.register(cellNib, forCellWithReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UICollectionViewControllerDataSource

extension CollectionViewModelController {
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sections.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.sections[section].items.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = dataSource.identifier(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? UICollectionViewCell & CollectionViewModelCell {
            configureCell(cell, at: indexPath)
        }
        return cell
    }
    
}

// MARK: - UICollectionViewControllerDelegate

extension CollectionViewModelController {
    
    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath),
            let collectionViewModelCell = cell as? CollectionViewModelCell
        else { return }
        collectionViewModelCell.action(cell)
    }
    
}
