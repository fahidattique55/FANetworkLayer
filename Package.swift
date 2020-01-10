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
        .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("4.9.1")),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .branch("3.5.1"))
    ],
    targets: [
        .target(name: "FANetworkLayer", dependencies: ["Alamofire", "ObjectMapper"], path: "FANetworkLayer/Source")
//        .target(name: "FANetworkLayer", path: "FANetworkLayer/Source")
    ]
)

