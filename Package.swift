// swift-tools-version:4.2

/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AEViewModel",
    products: [
        .library(name: "AEViewModel", targets: ["AEViewModel"])
    ],
    targets: [
        .target(
            name: "AEViewModel"
        ),
        .testTarget(
            name: "AEViewModelTests",
            dependencies: ["AEViewModel"]
        )
    ]
)
