// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "Sample",
    targets: [
        .executableTarget(
            name: "Sample",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
