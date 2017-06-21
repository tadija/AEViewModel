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
