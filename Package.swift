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
            url: "https://api.github.com/repos/skyglassapp/TailwindCSS/releases/assets/229008219.zip",
            checksum: "3721f88ce3f1b42b2f40f531152bab4e6ba39c51cf14bf41674647bd6554d600"
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
