/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

open class CollectionViewModelController: UICollectionViewController {
    
    // MARK: Properties

    open var isAutomaticReloadEnabled = true

    open var viewModel: ViewModel = BasicViewModel() {
        didSet {
            if isAutomaticReloadEnabled {
                reload()
            }
        }
    }
    
    // MARK: Init

    public convenience init() {
        self.init(viewModel: BasicViewModel())
    }
    
    public convenience init(viewModel: ViewModel, layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.init(collectionViewLayout: layout)
        self.viewModel = viewModel
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

    open func update(_ cell: CollectionViewModelCell, at indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        cell.update(with: item)
        cell.callback = { [weak self] sender in
            self?.action(for: cell, at: indexPath, sender: sender)
        }
    }

    open func action(for cell: CollectionViewModelCell, at indexPath: IndexPath, sender: Any) {}
    
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
        if let title = viewModel.title {
            self.title = title
        }
        registerCells()
        collectionView?.reloadData()
    }
    
    private func registerCells() {
        viewModel.uniqueIdentifiers.forEach { id in
            registerCell(with: id)
        }
    }
    
    private func registerCell(with identifier: String) {
        switch cellType(forIdentifier: identifier) {
        case .basic:
            collectionView?.register(CollectionCellBasic.self, forCellWithReuseIdentifier: identifier)
        case .customClass(let cellClass):
            collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
        case .customNib(let cellClass):
            collectionView?.register(cellClass.nib, forCellWithReuseIdentifier: identifier)
        }
    }
    
}

// MARK: - UICollectionViewControllerDataSource

extension CollectionViewModelController {
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView,
                                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = viewModel.identifier(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        if let cell = cell as? CollectionViewModelCell {
            update(cell, at: indexPath)
        }
        return cell
    }
    
}

// MARK: - UICollectionViewControllerDelegate

extension CollectionViewModelController {
    
    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewModelCell else {
            return
        }
        action(for: cell, at: indexPath, sender: self)
    }
    
}
