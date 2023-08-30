import PackagePlugin
import Foundation

@main
struct TailwindCSSCommand: CommandPlugin {
    func performCommand(
        context: PluginContext,
        arguments: [String]
    ) throws {
        Diagnostics.remark("\(arguments)")
        let tool = try context.tool(named: "tailwindcss")
        
        var argumentExtractor = ArgumentExtractor(arguments)
        _ = argumentExtractor.extractOption(named: "target")
        
        let url = URL(fileURLWithPath: tool.path.string)
        let process = try Process.run(url, arguments: argumentExtractor.remainingArguments)
        process.waitUntilExit()

        guard process.terminationReason == .exit && process.terminationStatus == 0 else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("Tailwind CSS initialization failed: \(problem)")
            return
        }
    }
}
