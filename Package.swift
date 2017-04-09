import PackageDescription

let package = Package(
    name: "TableModel",
    dependencies: [
        .Package(url: "https://github.com/tadija/mappable.git", majorVersion: 0)
    ],
    exclude: ["Example"]
)
