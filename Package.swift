import PackageDescription

let package = Package(
    name: "ZewoFlock",
    dependencies: [
        .Package(url: "../Flock", majorVersion: 0, minor: 0)
    ]
)
