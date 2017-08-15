# AEViewModel

**Swift minion for convenient creation of table and collection views**

[![Language Swift 3.0](https://img.shields.io/badge/Language-Swift%203.0-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](LICENSE)

[![CocoaPods Version](https://img.shields.io/cocoapods/v/AEViewModel.svg?style=flat)](https://cocoapods.org/pods/AEViewModel)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

> From my experience large part of almost any app's interface is going on in table or collection views.  
> But then again, anytime I need to make any new table / collection, I'm like AAARGH, NOT AGAIN!  
> This is my take on making that task easier for myself, and hopefully for others too.

![AEViewModel](http://tadija.net/public/AEViewModel.png)

> Idea behind this solution is somehow broad and implementation is very loose too, meaning that
> you may use this in many different ways or styles which are most appropriate to your case or liking.
>
> By proper usage of this framework, it will enforce you to write more clean and maintainable code by leveraging concepts of [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern. So you should probably understand ["manual" approach](https://medium.com/yay-its-erica/dabbling-with-mvvm-in-swift-3-3bbeba61b45b) first.
>
> Anyway, it may not be quick and easy (for everyone) to grasp at first look, but if you go deeper you may never wish to create another table or collection view without using this, just saying...

## Index
- [Features](#features)
- [Usage](#usage)
	- [Introduction](#introduction)
		- [ViewModel](#viewmodel)
		- [TableViewModelCell](#tableviewmodelcell)
		- [TableViewModelController](#tableviewmodelcontroller)
		- [CollectionViewModelCell](#collectionviewmodelcell)
		- [CollectionViewModelController](#collectionviewmodelcontroller)
	- [Example](#example)
		- [Static ViewModel](#static-viewmodel)
		- [Dynamic ViewModel](#dynamic-viewmodel)
		- [Custom Cell](#custom-cell)
- [Installation](#installation)
- [License](#license)

## Features
- Create custom table / collection based interface faster with less boilerplate
- Usable with static (menus, forms etc.) and dynamic (local, remote etc.) data
- Provides often used cells (Toggle, TextInput, Button) out of the box (and more coming)
- Proper usage enforces more clean and maintainable code (by leveraging [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern)

## Usage

### Introduction

#### ViewModel

I suggest to start by getting very familiar with [ViewModel.swift](Sources/ViewModel.swift), because you're gonna use that stuff a lot. There are actually only very simple protocols and basic structs, which are gonna serve as our "view models" (VM from MVVM).

In short, it all starts with empty `ViewModel` protocol, followed by `DataSource` which says that you must have `sections` in order to implement it. This one is later typealiased to `Table` or `Collection` depending on your needs.

There are also protocols `Section`, `Item` and `ItemData` and your custom models should conform to the latter one, easy like this:

```swift
	struct MyCustomModel: ItemData {}
```

Now, for each of those protocols there is a simple basic struct conforming to it, named like `BasicSection` or `Basicitem` etc.
Most of the time you should be able to do everything with these, but in case of need (or style) you may want to create custom types that conform to these protocols and use those. 

That's why [Example](Example) project tackles each sample table in a slightly different way to show multiple approaches that can be used. See [ExampleTable](Example/AEViewModelExample/ExampleTable.swift), [FormTable](Example/AEViewModelExample/FormTable.swift), [SettingsTable](Example/AEViewModelExample/SettingsTable.swift), [GithubTable](Example/AEViewModelExample/GithubTable.swift).

In the end, notice that `ViewModel.swift` doesn't import `UIKit` and it should stay like that in your implementation too. If you ask why then you didn't read enough about [MVVM](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52). *"ViewModel is basicaly basically UIKit independent representation of your View and its state."*

#### TableViewModelCell

On the `UIKit` side of things there is this `TableViewModelCell` protocol which should be implemented by `UITableViewCell` for things to work. Luckily for you, that's already included out of the box for some often used cell types:

```swift
public enum TableCell {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case button
    case toggle
    case textInput
    case customClass(type: TableViewModelCell.Type)
    case customNib(nib: UINib?)
}
```

These classes are defined in the extension of `TableCell` enum, so you would refer to them like `TableCell.Basic`, `TableCell.Subtitle` etc. Easiest way to use custom cells is to inherit from `TableCell.Basic` and override what you need:

```swift
	/// Called in `awakeFromNib`, you should make initial configuration of your interface here.
	func customize()
	
	/// Called in `tableView(_:cellForRowAt:)`, you should update your interface here.
	func update(with item: Item)
	
	/// Called in `prepareForReuse`, you should reset your interface here.
	func reset()
```

`TableViewModelCell` also defines `var action: (_ sender: Any) -> Void` property which you should probably want to set from the view controller in order to make the cell do what you want on `tableView(_:didSelectRowAt:)`.

#### TableViewModelController

Final part of this story is `TableViewModelController`, which you guessed it, inherits from `UITableViewController`.  

Only this one is nice enough to register, dequeue and update all cells you need, on its own.  
All you need to do to make this happen is to set its `model` property which is of type `Table`, remember that one?

Use it by inheriting from it with your `CustomTableViewModelController` and override what you need:

```swift
	/// Return appropriate cell type for given identifier.
	func cell(forIdentifier identifier: String) -> TableCell
	
	/// Update cell at index path, like customize look or set `action` for cell here.
	func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath)
```

#### CollectionViewModelCell 

> Unfortunately, collection views are not yet implemented but should be very similar to their table counterparts.

#### CollectionViewModelController

> Unfortunately, collection views are not yet implemented but should be very similar to their table counterparts.

### Example

Here's just a few examples (with just the important parts):

#### Static ViewModel

```swift
import AEViewModel

struct FormTable: Table {
    enum Cell: String {
        case username
        case password
        case accept
        case register
        
        var item: BasicItem {
            switch self {
            case .username:
                return BasicItem(identifier: rawValue, title: "Username")
            case .password:
                return BasicItem(identifier: rawValue, title: "Password")
            case .accept:
                return BasicItem(identifier: rawValue, title: "Accept Terms")
            case .register:
                return BasicItem(identifier: rawValue, title: "Register")
            }
        }
    }
    
    var sections: [Section]
    
    init() {
        let credentials = BasicSection(items: [Cell.username.item, Cell.password.item])
        let actions = BasicSection(items: [Cell.accept.item, Cell.register.item])
        sections = [credentials, actions]
    }
}

final class FormTVMC: TableViewModelController {
    
    typealias FormCell = FormTable.Cell
    
    // MARK: Override
    
    override func cell(forIdentifier identifier: String) -> TableCell {
        guard let formCell = FormCell(rawValue: identifier) else {
            return .basic
        }
        
        switch formCell {
        case .username, .password:
            return .textInput
        case .accept:
            return .toggle
        case .register:
            return .button
        }
    }
    
    override func configureCell(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.configureCell(cell, at: indexPath)
        
        guard
            let item = item(at: indexPath),
            let formCell = FormCell(rawValue: item.identifier)
        else {
            return
        }
        
        switch formCell {
        case .username:
            cell.action = { _ in
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.becomeFirstResponder(at: nextIndexPath)
            }
        case .password:
            (cell as? TableCell.TextInput)?.textField.isSecureTextEntry = true
            cell.action = { _ in
                let previousIndexPath = self.previousIndexPath(from: indexPath)
                self.becomeFirstResponder(at: previousIndexPath)
            }
        case .accept:
            cell.action = { sender in
                let enabled = (sender as? UISwitch)?.isOn ?? false
                let nextIndexPath = self.nextIndexPath(from: indexPath)
                self.updateButton(at: nextIndexPath, enabled: enabled)
            }
        case .register:
            (cell as? TableCell.Button)?.button.isEnabled = false
            cell.action = { _ in
                self.presentAlert()
            }
        }
    }
    
}
```

#### Dynamic ViewModel

```swift
import AEViewModel

extension BasicTable {
    enum GithubCellType: String {
        case repo
    }
}

final class GithubTVMC: TableViewModelController {
    
    typealias CellType = BasicTable.GithubCellType
    
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
    
}
```

#### Custom Cell

```swift
final class GithubRepoCell: TableCell.Basic {

    @IBOutlet weak var repoOwnerAvatar: UIImageView!
    
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var repoUpdateDate: UILabel!
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var stars: UILabel!
    
    // MARK: - TableCell
    
    override func customize() {
        repoOwnerAvatar.layer.cornerRadius = 32
        repoOwnerAvatar.layer.masksToBounds = true
    }
    
    override func update(with item: Item) {
        base?.accessoryType = .disclosureIndicator
        
        if let repo = item.data as? Repo {
            if let url = repo.ownerImageURL {
                repoOwnerAvatar.loadImage(from: url)
            }
            repoOwnerName.text = "@\(repo.owner.username)"
            repoUpdateDate.text = repo.updatedFormatted
            repoName.text = repo.name
            repoDescription.text = repo.description
            forks.text = "⋔ \(repo.forksCount)"
            stars.text = "★ \(repo.starsCount)"
        }
    }
}
```

> For more details check out [Sources](Sources) and [Example](Example).

## Installation

- [Swift Package Manager](https://swift.org/package-manager/):

	```
	.Package(url: "https://github.com/tadija/AEViewModel.git", majorVersion: 0)
	```

- [Carthage](https://github.com/Carthage/Carthage):

	```ogdl
	github "tadija/AEViewModel"
	```

- [CocoaPods](http://cocoapods.org/):

	```ruby
	pod 'AEViewModel'
	```

## License
This code is released under the MIT license. See [LICENSE](LICENSE) for details.
