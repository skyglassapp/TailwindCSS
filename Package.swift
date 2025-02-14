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
            url: "https://api.github.com/repos/skyglassapp/TailwindCSS/releases/assets/229000669.zip",
            checksum: "03851b3cb71ee429390b742b06e2dae9db9a5f329b17729d2b4f21148175a617"
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
