// swift-tools-version:5.10

import PackageDescription

let package = Package(
        name: "HUD",
        platforms: [
            .iOS(.v13),
        ],
        products: [
            .library(
                    name: "HUD",
                    targets: ["HUD"]),
        ],
        dependencies: [
            .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
            .package(url: "https://github.com/sunimp/ThemeKit.Swift.git", .upToNextMajor(from: "2.0.3")),
            .package(url: "https://github.com/sunimp/UIExtensions.Swift.git", .upToNextMajor(from: "1.0.2")),
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
