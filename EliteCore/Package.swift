// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EliteCore",
    products: [
        .library(name: "EliteCore", targets: ["EliteCore"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "EliteCore", dependencies: []),
        .testTarget(name: "EliteCoreTests", dependencies: ["EliteCore"]),
    ]
)
