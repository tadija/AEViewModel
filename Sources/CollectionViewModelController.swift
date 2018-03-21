/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class CollectionViewModelController: UICollectionViewController {
    
    // MARK: Properties
    
    open var model: DataSource = BasicDataSource() {
        didSet {
            reload()
        }
    }
    
    open var isAutomaticReloadEnabled = true
    
    // MARK: Init
    
    public convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    public convenience init(collectionViewLayout layout: UICollectionViewLayout, model: DataSource) {
        self.init(collectionViewLayout: layout)
        self.model = model
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
        let item = model.item(at: indexPath)
        cell.update(with: item)
    }
    
    // MARK: API
    
    public func item(from cell: CollectionViewModelCell) -> Item? {
        guard
            let collectionViewCell = cell as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: collectionViewCell)
        else { return nil }
        return model.item(at: indexPath)
    }
    
    public func pushCollection(from item: Item, in cvmc: CollectionViewModelController) {
        /// - TODO: check later
//        if let basicViewModel = item.model as? BasicViewModel, let child = basicViewModel.child {
//            cvmc.model = child
//            navigationController?.pushViewController(cvmc, animated: true)
//        }
    }
    
    public func nextIndexPath(from indexPath: IndexPath) -> IndexPath? {
        guard let cv = collectionView else {
            return nil
        }
        var newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        if newIndexPath.row >= collectionView(cv, numberOfItemsInSection: indexPath.section) {
            let newSection = indexPath.section + 1
            newIndexPath = IndexPath(item: 0, section: newSection)
            if newSection >= numberOfSections(in: cv) {
                return nil
            }
        }
        return newIndexPath
    }
    
    public func previousIndexPath(from indexPath: IndexPath) -> IndexPath? {
        guard let cv = collectionView else {
            return nil
        }
        var newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        if newIndexPath.row < 0 {
            let newSection = indexPath.section - 1
            if newSection < 0 {
                return nil
            }
            let maxRow = collectionView(cv, numberOfItemsInSection: newSection) - 1
            newIndexPath = IndexPath(item: maxRow, section: newSection)
        }
        return newIndexPath
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
        if isAutomaticReloadEnabled {
            collectionView?.reloadData()
        }
    }
    
    private func registerCells() {
        var uniqueIdentifiers: Set<String> = Set<String>()
        model.sections.forEach { section in
            let sectionIdentifiers: [String] = section.items.flatMap({ $0.identifier })
            uniqueIdentifiers.formUnion(sectionIdentifiers)
        }
        uniqueIdentifiers.forEach { identifier in
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
        return model.sections.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.sections[section].items.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = model.identifier(at: indexPath)
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
