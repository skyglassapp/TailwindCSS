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
            path: "tailwindcss.artifactbundle"
            // url: "https://foo.com/tailwindcss.artifactbundle.zip",
            // checksum: ""
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
