// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "FANetworkLayer",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "FANetworkLayer",
            targets: ["FANetworkLayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("5.0.0-rc.3"))
    ],
    targets: [
        .target(name: "FANetworkLayer", path: "FANetworkLayer/Source")
    ]
)

