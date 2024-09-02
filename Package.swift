// swift-tools-version:5.10

import PackageDescription

let package = Package(
        name: "HUD",
        platforms: [
            .iOS(.v14),
            .macOS(.v12)
        ],
        products: [
            .library(
                    name: "HUD",
                    targets: ["HUD"]),
        ],
        dependencies: [
            .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
            .package(url: "https://github.com/sunimp/ThemeKit.Swift.git", .upToNextMajor(from: "2.2.0")),
            .package(url: "https://github.com/sunimp/UIExtensions.Swift.git", .upToNextMajor(from: "1.3.0")),
            .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.54.3"),
        ],
        targets: [
            .target(
                    name: "HUD",
                    dependencies: [
                        "SnapKit",
                        .product(name: "ThemeKit", package: "ThemeKit.Swift"),
                        .product(name: "UIExtensions", package: "UIExtensions.Swift"),
                    ]
            ),
        ]
)
