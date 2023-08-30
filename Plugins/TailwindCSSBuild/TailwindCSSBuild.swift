import PackagePlugin

@main
struct TailwindCSSBuild: BuildToolPlugin {    
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        guard let target = target as? SourceModuleTarget else { return [] }
        let inputFiles = target.sourceFiles.filter({ $0.path.extension == "css" })
        return try inputFiles.map { inputFile in
            let inputPath = inputFile.path
            let outputName = inputPath.stem + ".css"
            let outputPath = context.pluginWorkDirectory.appending(outputName)
            let configurationPath = context.package.directory.appending("tailwind.config.js")
            return .buildCommand(
                displayName: "Generating \(outputName) from \(inputPath.lastComponent)",
                executable: try context.tool(named: "tailwindcss").path,
                arguments: [
                    "-i", "\(inputPath)",
                    "-o", "\(outputPath)",
                    "-c", "\(configurationPath)"
                ],
                inputFiles: target.sourceFiles.map(\.path) + [configurationPath],
                outputFiles: [outputPath]
            )
        }
    }
}
