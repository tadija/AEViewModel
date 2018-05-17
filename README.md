[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![CocoaPods](https://img.shields.io/cocoapods/v/AEViewModel.svg?style=flat)](https://cocoapods.org/pods/AEViewModel)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tadija/AEViewModel/blob/master/LICENSE)

# AEViewModel

**Swift minion for convenient creation of table and collection views**

> I made this for personal use, but feel free to use it or contribute.
> For more examples check out [Sources](Sources) and [Tests](Tests).

![AEViewModel](http://tadija.net/public/AEViewModel.png)

## Index
- [Intro](#intro)
- [Features](#features)
- [Usage](#usage)
	- [ViewModel](#viewmodel)
	- [BasicViewModel](#basicviewmodel)
	- [ViewModelCell](#viewmodelcell)
	- [TableViewModelCell](#tableviewmodelcell)
	- [CollectionViewModelCell](#collectionviewmodelcell)
	- [TableViewModelController](#tableviewmodelcontroller)
	- [CollectionViewModelController](#collectionviewmodelcontroller)
	- [Example](#example)
- [Installation](#installation)
- [License](#license)

## Intro

Almost any app's interface is often going on in table or collection views.
This is my take on making that task easier for myself, and hopefully for others too.

Idea behind this solution is quite abstract, meaning that it may be applied in many different ways (or styles) which are the most appropriate to your case or liking.

By proper usage of this framework, it will enforce you to write more clean and maintainable code by leveraging concepts of [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern. In order to understand it better you should be familiar with the ["manual" approach](https://medium.com/yay-its-erica/dabbling-with-mvvm-in-swift-3-3bbeba61b45b) in the first place.

It may not be quick and easy (for everyone) to grasp at the first look, but if you give it a proper chance you may never want to create another table or collection view without using this, just saying...

## Features
- Create custom table / collection based interface faster with less boilerplate
- Usable with static (menus, forms etc.) and dynamic (local, remote etc.) data
- Provides often used cells (TextInput, Slider, Toggle, Button etc.) out of the box

## Usage

### ViewModel

I suggest to start by getting familiar with [ViewModel.swift](Sources/ViewModel.swift), because you're essentially gonna use that stuff for everything.

These are just very simple protocols starting with `ViewModel` which must have sections, then `Section` must have items, where each `Item` contains `identifier` and `Model`. Model here is whatever you choose it to be, easy like this:

```swift
struct MyCustomModel: Model {}
```

### BasicViewModel

There are simple structs conforming to all of these protocols in [BasicViewModel.swift](Sources/BasicViewModel.swift) and most of the time it should be possible to just use those. As these structs conform to `Codable` too, it is also possible to create `BasicViewModel` from JSON data for example.

In case of something more specific, create custom types that conform to these protocols and use those instead.

### ViewModelCell

There is a simple protocol in [ViewModelCell.swift](Sources/ViewModelCell.swift) which is used both for table and collection view cells. Note that `TableViewModelCell` and `CollectionViewModelCell` are just a simple typealiases:

```swift
public typealias TableViewModelCell = UITableViewCell & ViewModelCell
public typealias CollectionViewModelCell = UICollectionViewCell & ViewModelCell
```

When creating custom cells, the easiest way is to subclass from `TableCellBasic` or `CollectionCellBasic` and override methods from this protocol:

```swift
/// Called in `init` and `awakeFromNib`, configure outlets and layout here.
func configure()

/// Called in `configure` and `prepareForReuse`, reset interface here.
func reset()

/// Called in `tableView(_:cellForRowAt:)`, update interface with model here.
func update(with item: Item)
```

To use default callback from cell to view controller just call `performCallback(_:)` where it makes sense for your cell.

### TableViewModelCell

There are a few often used table view cells provided out of the box:

```swift
public enum TableCellType {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case textInput
    case slider
    case toggle
    case toggleSubtitle
    case button
    case customClass(TableViewModelCell.Type)
    case customNib(TableViewModelCell.Type)
}
```

### CollectionViewModelCell

While for the collection view cells you probably want to create something custom... :)

```swift
public enum CollectionCellType {
    case basic
    case customClass(CollectionViewModelCell.Type)
    case customNib(CollectionViewModelCell.Type)
}
```

### TableViewModelController

Final part of this story is `TableViewModelController`, which you guessed it, inherits from `UITableViewController`.  

Only this one is nice enough to register, dequeue and update all cells you'll ever need by just configuring its `viewModel` property and overriding these methods:

```swift
/// - Note: Return proper cell type for the given item identifier.
/// Based on this it knows which cells to register for which identifier.
open func cellType(forIdentifier identifier: String) -> TableCellType {
    return .basic
}

/// - Note: Update cell at the given index path. 
/// `TableViewModelController` does this by default, so if that's enough for your case just skip this,
/// otherwise call `super.update(cell, at: indexPath)` and add custom logic after that.
open func update(_ cell: c, at indexPath: IndexPath) {
    let item = viewModel.item(at: indexPath)
    cell.update(with: item)
    cell.delegate = self
}

/// - Note: Handle action from cell for the given index path.
/// This will be called in `tableView(_:didSelectRowAt:)` or when `performCallback(_:)` is called
open func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {}
```

### CollectionViewModelController

This is almost a duplicate of `TableViewModelController` but it's using `CollectionViewModelCell` so there's that.

### Example

You should take a look at [the example project](Example), but here's a quick preview:

```swift
import AEViewModel

struct ExampleViewModel: ViewModel {
    struct Id {
        static let cells = "cells"
        static let form = "form"
        static let settings = "settings"
        static let github = "github"
    }

    var title: String? = "Example"
    var sections: [Section] = [
        BasicSection(footer: "Default cells which are provided out of the box.", items: [
            BasicItem(identifier: Id.cells, title: "Cells")
        ]),
        BasicSection(header: "Demo", items: [
            BasicItem(identifier: Id.form, title: "Form", detail: "Static View Model"),
            BasicItem(identifier: Id.settings, title: "Settings", detail: "JSON View Model"),
            BasicItem(identifier: Id.github, title: "Github", detail: "Remote View Model")
        ])
    ]
}

final class ExampleTVMC: TableViewModelController {
    
    typealias Id = ExampleViewModel.Id
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ExampleViewModel()
    }
    
    // MARK: Override
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        return .subtitle
    }
    
    override func update(_ cell: TableViewModelCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        cell.accessoryType = .disclosureIndicator
    }

    override func action(for cell: TableViewModelCell, at indexPath: IndexPath, sender: Any) {
        switch viewModel.identifier(at: indexPath) {
        case Id.cells:
            show(CellsTVMC(), sender: self)
        case Id.form:
            show(FormTVMC(), sender: self)
        case Id.settings:
            show(MainSettingsTVMC(), sender: self)
        case Id.github:
            show(GithubTVMC(), sender: self)
        default:
            break
        }
    }
    
}
```

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
