[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://www.apple.com)
[![CocoaPods](https://img.shields.io/cocoapods/v/AEViewModel.svg?style=flat)](https://cocoapods.org/pods/AEViewModel)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](LICENSE)

# AEViewModel

**Swift minion for convenient creation of table and collection views**

> I made this for personal use, but feel free to use it or contribute.
> For more examples check out [Sources](Sources) and [Tests](Tests).

![AEViewModel](http://tadija.net/public/AEViewModel.png)

## Index
- [Intro](#intro)
- [Features](#features)
- [Usage](#usage)
	- [DataSource](#datasource)
	- [BasicDataSource](#basicdatasource)
	- [Cell](#cell)
	- [TableCell](#tablecell)
	- [CollectionCell](#collectioncell)
	- [TableViewController](#tableviewcontroller)
	- [CollectionViewController](#collectionviewcontroller)
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

### DataSource

I suggest to start by getting familiar with [DataSource.swift](Sources/DataSource.swift), because you're essentially gonna use that stuff for everything.

These are just very simple protocols starting with `DataSource` which must have sections, then `Section` must have items, where each `Item` contains `identifier: String`, `viewModel: ViewModel` and `child: DataSource?`.

```swift
/// ViewModel is whatever you choose it to be, easy like this:
struct MyCustomWhatever: ViewModel {}
```

### BasicDataSource

There are simple structs conforming to all of these protocols in [BasicDataSource.swift](Sources/BasicDataSource.swift) and most of the time it should be possible to just use those. As these structs conform to `Codable` too, it is also possible to create `BasicDataSource` from JSON data for example.

In case of something more specific, create custom types that conform to these protocols and use those instead.

### Cell

There is a simple protocol in [Cell.swift](Sources/Cell.swift) which is used both for table and collection view cells. Note that `TableCell` and `CollectionCell` are just a simple typealiases:

```swift
public typealias TableCell = UITableViewCell & Cell
public typealias CollectionCell = UICollectionViewCell & Cell
```

When creating custom cells, the easiest way is to subclass from `TableCellBasic` or `CollectionCellBasic` and override methods from this protocol:

```swift
/// Called in `init` and `awakeFromNib`, configure outlets and layout here.
func configure()

/// Called in `configure` and `prepareForReuse`, reset interface here.
func reset()

/// Called in `tableView(_:cellForRowAt:)`, update interface with view model here.
func update(with item: Item)

/// Called in `tableView(_:didSelectRowAt:)` and whenever specific cell calls it (ie. toggle switch).
/// By default this call will be forwarded to `delegate` (after setting some `userInfo` optionally).
/// If needed, call this where it makes sense for your cell, or override and call `super` at some moment.
func callback(_ sender: Any)
```

### TableCell

There are a few often used table view cells provided out of the box:

```swift
public enum TableCellType {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case toggle
    case toggleWithSubtitle
    case slider
    case sliderWithLabels
    case textField
    case textView
    case button
    case spinner
    case customClass(TableCell.Type)
    case customNib(TableCell.Type)
}
```

### CollectionCell

While for the collection view cells you probably want to create something more custom... :)

```swift
public enum CollectionCellType {
    case basic
    case button
    case spinner
    case customClass(CollectionCell.Type)
    case customNib(CollectionCell.Type)
}
```

### TableViewController

Final part of this story is `TableViewController`, which you guessed it, inherits from `UITableViewController`.  

Only this one is nice enough to register, dequeue and update all cells you'll ever need by just configuring its `dataSource` property and overriding these methods:

```swift
/// - Note: Return proper cell type for the given item identifier.
/// Based on this it knows which cells to register for which identifier.
open func cellType(forIdentifier identifier: String) -> TableCellType {
    return .basic
}

/// - Note: Update cell at the given index path. 
/// `TableViewController` does this by default, so if that's enough for your case just skip this,
/// otherwise call `super.update(cell, at: indexPath)` and add custom logic after that.
open func update(_ cell: TableCell, at indexPath: IndexPath) {
    let item = viewModel.item(at: indexPath)
    cell.update(with: item)
    cell.delegate = self
}

/// - Note: Handle action from cell for the given index path.
/// This will be called in `tableView(_:didSelectRowAt:)` or when `callback(_:)` is called
open func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {}
```

### CollectionViewController

This is almost a duplicate of `TableViewController` but it's using `CollectionCell` so there's that.

### Example

You should take a look at [the example project](Example), but here's a quick preview:

```swift
import AEViewModel

struct ExampleDataSource: DataSource {
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
            BasicItem(identifier: Id.form, title: "Form", detail: "Static Data Source"),
            BasicItem(identifier: Id.settings, title: "Settings", detail: "JSON Data Source"),
            BasicItem(identifier: Id.github, title: "Github", detail: "Remote Data Source")
        ])
    ]
}

final class ExampleTVC: TableViewController {
    
    typealias Id = ExampleDataSource.Id
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ExampleDataSource()
    }
    
    // MARK: Override
    
    override func cellType(forIdentifier identifier: String) -> TableCellType {
        return .subtitle
    }
    
    override func update(_ cell: TableCell, at indexPath: IndexPath) {
        super.update(cell, at: indexPath)
        cell.accessoryType = .disclosureIndicator
    }

    override func action(for cell: TableCell, at indexPath: IndexPath, sender: Any) {
        switch dataSource.identifier(at: indexPath) {
        case Id.cells:
            show(CellsTVC(), sender: self)
        case Id.form:
            show(FormTVC(), sender: self)
        case Id.settings:
            show(MainSettingsTVC(), sender: self)
        case Id.github:
            show(GithubTVC(), sender: self)
        default:
            break
        }
    }
    
}
```

## Installation

- [Swift Package Manager](https://swift.org/package-manager/):

	```swift
	.package(url: "https://github.com/tadija/AEViewModel.git", from: "0.9.0")
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
