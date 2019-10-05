// swift-tools-version:5.0

/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright (c) Marko Tadić 2017-2019
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "AEViewModel",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "AEViewModel",
            targets: ["AEViewModel"]
        )
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
