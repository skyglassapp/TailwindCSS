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
            url: "https://api.github.com/repos/skyglassapp/TailwindCSS/releases/assets/123876348.zip",
            checksum: "275f26851ded3e2ee2fa5874e90a95529851d05e6b7dbf7cacc6c78895fefe72"
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
