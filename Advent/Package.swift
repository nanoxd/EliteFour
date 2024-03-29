// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Advent",
    platforms: [.macOS(.v10_14)],
    products: [
        .executable(name: "adv", targets: ["adv"]),
        .library(name: "Advent", targets: ["Advent"]),
        .library(name: "AdventFoundation", targets: ["AdventFoundation"]),
        .library(name: "AOC2019", targets: ["AOC2019"]),
        .library(name: "AOC2015", targets: ["AOC2015"]),
    ],
    dependencies: [
        .package(path: "../EliteCore"),
    ],
    targets: [
        .target(name: "adv", dependencies: ["Advent"]),
        .target(name: "Advent", dependencies: ["AOC2015", "AOC2019"]),
        .testTarget(name: "AdventTests", dependencies: ["Advent"]),
        .target(name: "AdventFoundation", dependencies: ["EliteCore"]),
        .testTarget(
            name: "AdventFoundationTests",
            dependencies: ["AdventFoundation"]
        ),
        .target(name: "AOC2019", dependencies: ["AdventFoundation"]),
        .target(name: "AOC2015", dependencies: ["AdventFoundation"]),
    ]
)
