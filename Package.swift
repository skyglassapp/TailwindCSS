// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "TailwindCSS",
    products: [
        .plugin(
            name: "TailwindCSSBuild",
            targets: [
                "TailwindCSSBuild",
            ]
        ),
        .plugin(
            name: "TailwindCSSCommand",
            targets: [
                "TailwindCSSCommand"
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "tailwindcss",
            url: "https://api.github.com/repos/skyglassapp/TailwindCSS/releases/assets/228990176.zip",
            checksum: "0e6d1b8e535953531a6e73abf185a2ba2289f29f3ad9948729c201a21f6a9203"
        ),
        .plugin(
            name: "TailwindCSSBuild",
            capability: .buildTool(),
            dependencies: [
                .target(name: "tailwindcss")
            ]
        ),
        .plugin(
            name: "TailwindCSSCommand",
            capability: .command(intent: .custom(verb: "tailwindcss", description: "Run tailwindcss command"), permissions: [.writeToPackageDirectory(reason: "Write configuration and output files")]),
            dependencies: [
                .target(name: "tailwindcss")
            ]
        )
    ]
)
