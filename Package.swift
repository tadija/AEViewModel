// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "TableModel",
    dependencies: [
        .Package(url: "https://github.com/tadija/convertible.git", majorVersion: 0)
    ],
    exclude: ["Example"]
)
