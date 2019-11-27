// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Advent",
    platforms: [.macOS(.v10_14)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "adv", targets: ["adv"]),
        .library(
            name: "Advent",
            targets: ["Advent"]
        ),
        .library(
            name: "AdventFoundation",
            targets: ["AdventFoundation"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "adv",
            dependencies: ["Advent"]
        ),
        .target(
            name: "Advent",
            dependencies: []
        ),
        .testTarget(
            name: "AdventTests",
            dependencies: ["Advent"]
        ),
        .target(
            name: "AdventFoundation",
            dependencies: []
        ),
        .testTarget(
            name: "AdventFoundationTests",
            dependencies: ["AdventFoundation"]
        ),
    ]
)
