// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EliteCore",
    platforms: [.macOS(.v10_14)],
    products: [
        .library(name: "EliteCore", targets: ["EliteCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nanoxd/Nano", "0.0.2"..."1.0.0"),
    ],
    targets: [
        .target(name: "EliteCore", dependencies: ["Nano"]),
        .testTarget(name: "EliteCoreTests", dependencies: ["EliteCore"]),
    ]
)
