// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NeoDBKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .macCatalyst(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NeoDBClient",
            targets: ["NeoDBClient"]
        ),
        .library(
            name: "NeoDBModels",
            targets: ["NeoDBModels"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.6.0"),
        .package(url: "https://github.com/lcandy2/SymbolKit.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NeoDBClient",
            dependencies: ["NeoDBModels"]
        ),
        .target(
            name: "NeoDBModels",
            dependencies: [
                "SwiftSoup",
                "SymbolKit"
            ],
            resources: [
              .process("Resources")
            ]
        ),

    ]
)
