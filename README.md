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

> Idea behind this solution is somehow very broad, implementation is very loose too.  
> That means, you may use it in many different ways or styles which are most appropriate to your case or liking.  
> I think that by proper usage of this framework, it enforces you to write more clean and maintainable code by leveraging concepts of [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) pattern. So you should probably be familiar with that first (in case I'm wrong).  
> Anyway, it may not be quick and easy (for everyone) to grasp at first look, but if you go deeper you may never wish to create another table or collection view without using this, just saying...

## Index
- [Features](#features)
- [Usage](#usage)
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

In short, it all starts with empty `ViewModel` protocol, followed by `DataSourceModel` which says that you must have a `title` and `sections` in order to implement it. This one is later typealiased to `Table` or `Collection` depending on your needs.

There are also protocols `Section`, `Item` and `ItemData` and your custom models should conform to the latter one, easy like this:

```swift
	struct MyCustomModel: ItemData { /* ... */ }
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

#### CollectionViewModelCell & CollectionViewModelController

Unfortunately, those are not yet implemented but should be very similar to their table counterparts.

### Example

```swift
/// - Note: some usage example
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
