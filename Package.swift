// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "bonanas",
    platforms: [.macOS(.v11),
                .iOS(.v14),
                .tvOS(.v14),
                .watchOS(.v7)],
    products: [
        .library(
            name: "bonanas",
            targets: ["bonanas"]),
        
    ],
    dependencies: [
        .package(url: "https://github.com/christopherweems/unstandard.git", .upToNextMajor(from: "0.0.21")),
        
    ],
    targets: [
        .target(
            name: "bonanas",
            dependencies: [
                .product(name: "unstandard", package: "unstandard"),
                
            ]),
        .testTarget(
            name: "bonanasTests",
            dependencies: ["bonanas"]),
        
    ]
)
