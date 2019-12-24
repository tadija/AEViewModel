// swift-tools-version:5.1

/**
 *  https://github.com/tadija/AEViewModel
 *  Copyright © 2017-2019 Marko Tadić
 *  Licensed under the MIT license
 */

import PackageDescription

let package = Package(
    name: "AEViewModel",
    platforms: [
        .iOS(.v9)
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
