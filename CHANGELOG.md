# Changelog

## Version 0.9.2

- Register cells on dequeue
- Run swiftlint autocorrect

## Version 0.9.1

- Minor fixes

## Version 0.9.0

- Migrate to Swift 5 with Xcode 11 (11A420a)
- Update "swift_versions" in podspec file

## Version 0.8.3

- Bumping Swift language version to 4.2 with Xcode 10
- Minor other changes

## Version 0.8.2

- Simplified callback logic
- Added TableCellTextView, TableCellSpinner, CollectionCellButton, CollectionCellSpinner
- Other improvements and refactoring

## Version 0.8.1

- Minor bug fixes, improvements and refactoring

## Version 0.8.0

- Renamed `ViewModelCell` -> `Cell`
- Renamed `ViewModelCellDelegate` -> `CellDelegate`
- Renamed `TableViewModelCell` -> `TableCell`
- Renamed `TableViewModelController` -> `TableViewController`
- Renamed `CollectionViewModelCell` -> `CollectionCell`
- Renamed `CollectionViewModelController` -> `CollectionViewController`
- Added `userInfo` to `callback` in `ViewModelCell`
- Added `TableCellUserInfo` enum for default `userInfo` keys

## Version 0.7.0

- Renamed `ViewModel` -> `DataSource`
- Renamed `Model` -> `ViewModel`
- Moved `child` from `ViewModel` into `Item`
- Removed `title`, `detail`, `image` properties from `ViewModel`
- Added `callback(_:)` to `ViewModelCell`
- Added default view models for slider and toggle cells
- Renamed a few cells

## Version 0.6.6

- Added `userInfo` property to `ViewModelCell`
- Enabled overriding of `performCallback` in cells
- Added `TableCellStack` and `CollectionCellStack`

## Version 0.6.5

- Added new default cell `TableCellSliderLabels`
- Renamed `setup` -> `configure`
- Improvements and refactoring

## Version 0.6.4

- Added new default cell `TableCellSlider`
- Improvements and refactoring
- Improved demo project

## Version 0.6.3

- Minor bug fixes and improvements

## Version 0.6.2

- Hot fix with workaround for bug in Swift 4.1 [SR-7335]
- Bumped `swift_version` in podspec file to 4.1

## Version 0.6.1

- Migrated to Swift 4.1 with Xcode 9.3 (9E145)

## Version 0.6.0

- Major improvements and refactoring
- README.md is up to date

## Version 0.5.1

- Minor fixes and improvements

## Version 0.5.0

- Added initial support for `UICollectionViewController`
- Changed class names to have better compatibility in complex projects
- Minor improvements and bug fixes

## Version 0.4.1

- Reverted build system from New to Standard

## Version 0.4.0

- Simplification
- Improvements and refactoring

## Version 0.3.5

- Migrated to Swift 4

## Version 0.3.4

- First public release
- README.md
- Minor improvements and refactoring

## Version 0.3.3

- Improvements and refactoring 

## Version 0.3.2

- Created custom cell from nib in Github sample
- Improvements and refactoring

## Version 0.3.1

- Improvements and refactoring
- Improving Github sample in Example

## Version 0.3.0

- Added Github sample to Example project
- Added [Network](https://github.com/tadija/mappable) dependecy to Example project
- Improvements and refactoring

## Version 0.2.8

- Improvements and refactoring

## Version 0.2.7

- Improvements and refactoring

## Version 0.2.6

- Improvements and refactoring

## Version 0.2.5

- Renamed framework: `AETable` -> `AEViewModel`
- Improvements and refactoring

## Version 0.2.4

- Renamed framework: `Table` -> `AETable`

## Version 0.2.3

- Removed [Mappable](https://github.com/tadija/mappable) dependency and Carthage from Framework project
- Added Carthage and [Mappable](https://github.com/tadija/mappable) dependency to Example project

## Version 0.2.2

- Added `MappableViewModel` in Example
- Added table from `settings.json` in Example
- Improvements and refactoring 

## Version 0.2.1

- Improvements and refactoring

## Version 0.2.0

- Moving to MVVM approach
- Added button cell
- Improvements and refactoring

## Version 0.1.7

- Improvements and refactoring
- Added text input cell

## Vesion 0.1.6

- Improvements and refactoring

## Vesion 0.1.5

- Improvements and refactoring

## Vesion 0.1.4

- Improvements and refactoring

## Version 0.1.3

- Renamed framework: `TableModel` -> `Table`

## Version 0.1.2

- Improvements to allow easier making of custom models in code

## Version 0.1.1

- Usage improvements

## Version 0.1.0

- Initial version
