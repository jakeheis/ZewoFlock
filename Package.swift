import PackageDescription

let package = Package(
    name: "ZewoFlock",
    dependencies: [
        .Package(url: "https://github.com/jakeheis/Flock", majorVersion: 0, minor: 1)
    ]
)
