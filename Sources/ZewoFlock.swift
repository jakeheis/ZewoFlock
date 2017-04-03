import Flock

public extension Flock {
    static let Zewo: [Task] = SupervisordTasks(provider: ZewoSupervisord()).createTasks()
}

class ZewoSupervisord: SupervisordProvider {
    let taskNamespace = "zewo"
    let supervisordName = Config.supervisordName ?? "zewo"
    
    func confFile(for server: Server) -> SupervisordConfFile {
        var processCount = 1
        do {
            if let processCountString = try server.capture("nproc")?.trimmingCharacters(in: .whitespacesAndNewlines),
                let processCountInt = Int(processCountString) {
                processCount = processCountInt
            }
        } catch {}
        
        var file = SupervisordConfFile(programName: supervisordName)
        file.add("numprocs=\(processCount)")
        return file
    }
}
