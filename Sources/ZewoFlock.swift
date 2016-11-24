import Flock

public extension Flock {
    static let Zewo: [Task] = SupervisordTasks(provider: ZewoSupervisord()).createTasks()
}

class ZewoSupervisord: SupervisordProvider {
    let name = "zewo"
    let programName = "zewo"
    
    func confFileContents(for server: Server) -> String {
        var processCount = 1
        do {
            if let processCountString = try server.capture("nproc"), let processCountInt = Int(processCountString) {
                processCount = processCountInt
            }
        } catch {}
        
        return [
            "[program:\(programName)]",
            "command=\(Paths.executable)",
            "process_name=%(process_num)s",
            "numprocs=\(processCount)",
            "autostart=false",
            "autorestart=unexpected",
            ""
        ].joined(separator: "\n")
    }
}
