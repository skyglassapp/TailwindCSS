# Tailwind CSS Plugin for Swift Package Manager

## Usage

This plugin is intended for use with Vapor.

Add `.package(url: "https://github.com/skyglassapp/TailwindCSS.git", from: "0.1.1")` to your package dependencies and `.plugin(name: "TailwindCSSBuild", package: "TailwindCSS")` to your target plugins.

Add your tailwind.config.js to the root of the package and your index.css to your target source directory. All other static resources should also be added to the source directory and added to your target resources as `.copy(_:)`.

When you build your target, Tailwind CSS will process your index.css and copy it to the root of your bundle alongside your other resources. Vapor's `FileMiddleware` normally loads static resources from the `Public` directory at the package root, so we need to have it load from the bundle instead:

```swift
app.middleware.use(try FileMiddleware(bundle: Bundle.module, publicDirectory: "/"))
```

## Releasing

To release a new binary:

1. Create an [artifact bundle](https://github.com/apple/swift-evolution/blob/main/proposals/0305-swiftpm-binary-target-improvements.md#artifact-bundle) containing the latest release of the Tailwind CSS [standalone CLI](https://tailwindcss.com/blog/standalone-cli):

    ```
    tailwindcss.artifactbundle/
    ├── info.json
    ├── tailwindcss-linux-x86
    ├── tailwindcss-macos-arm64
    └── tailwindcss-windows-x64.exe
    ```

    `info.json`

    ```json
    {
        "schemaVersion": "1.0",
        "artifacts": {
            "tailwindcss": {
                "version": "<version>",
                "type": "executable",
                "variants": [
                    {
                        "path": "tailwindcss-macos-arm64",
                        "supportedTriples": ["arm64-apple-macosx"]
                    },
                    {
                        "path": "tailwindcss-linux-x64",
                        "supportedTriples": ["x86_64-unknown-linux-gnu"]
                    },
                    {
                        "path": "tailwindcss-windows-x64.exe",
                        "supportedTriples": ["x86_64-pc-windows-msvc"]
                    }
                ]
            }
        }
    }
    ```

2. Make sure Unix executables have their executable bit set:

    ```bash
    chmod +x tailwindcss.artifactbundle/tailwindcss-linux-x64
    chmod +x tailwindcss.artifactbundle/tailwindcss-macos-arm64
    ```

3. Compress the artifact bundle into a ZIP file:

    ```bash
    zip -r tailwindcss_<tag>.artifactbundle.zip tailwindcss.artifactbundle
    ```

4. Draft a release on GitHub using the [GitHub CLI](https://cli.github.com):

    ```bash
    gh release create <tag> tailwindcss_<tag>.artifactbundle.zip --title <tag> --generate-notes --draft
    ```

5. Get info about the asset:

    ```bash
    gh release view <tag> --json assets
    ```

6. Copy the `apiUrl` value and set it as the `url` value of the binary target in `Package.swift`, appending `.zip`.

7. From the root of the Swift package, compute the checksum of the ZIP file:

   ```bash
   swift package compute-checksum tailwindcss_<tag>.artifactbundle.zip
   ```

8. Copy the checksum and set it as the `checksum` value of the binary target in `Package.swift`.

9. Commit and tag the repository, and push the commit and tag.

10. Publish the release:

    ```bash
    gh release edit <tag> --draft=false
    ```
