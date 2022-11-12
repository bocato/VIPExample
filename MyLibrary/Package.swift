// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyLibrary",
            targets: [
                "MyLibrary",
                "Domain",
                "Services",
                "DependencyInjection",
                "UI",
                "MyFoundation",
                "Feature-ExampleScene",
                "Feature-ExampleScene2"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.5.0"),
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MyLibrary",
            dependencies: []
        ),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: ["MyLibrary"]
        ),
        
        // Core Modules
        .target(
            name: "DependencyInjection",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "MyFoundation",
            dependencies: [
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        
        // UI Modules
        .target(
            name: "UI",
            dependencies: [
                "MyFoundation",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        
        // Domain
        .target(
            name: "Domain",
            dependencies: [
                "Services",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        
        // Data
        .target(
            name: "Services",
            dependencies: [
                "DependencyInjection",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        
        // Features
        .target(
            name: "Feature-ExampleScene",
            dependencies: [
                "DependencyInjection",
                "Services",
                "Domain",
                "UI",
                "Feature-ExampleScene2",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
        .target(
            name: "Feature-ExampleScene2",
            dependencies: [
                "DependencyInjection",
                "Services",
                "Domain",
                "UI",
                .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
            ]
        ),
    ]
)
