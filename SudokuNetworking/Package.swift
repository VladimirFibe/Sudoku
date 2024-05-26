// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SudokuNetworking",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "SudokuNetworking",
            targets: ["SudokuNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ShapovalovIlya/SwiftFP.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SudokuNetworking",
            dependencies: [
                .product(name: "SwiftFP", package: "SwiftFP")
            ]
        ),
        .testTarget(
            name: "SudokuNetworkingTests",
            dependencies: ["SudokuNetworking"]),
    ]
)
