// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Telink",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "Telink",
            targets: ["Telink"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Bluetooth.git",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/PureSwift/GATT.git",
            from: "3.2.0"
        )
    ],
    targets: [
        .target(
            name: "Telink",
            dependencies: [
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
                .product(
                    name: "GATT",
                    package: "GATT"
                ),
            ]
        ),
        .testTarget(
            name: "TelinkTests",
            dependencies: ["Telink"]
        ),
    ]
)
