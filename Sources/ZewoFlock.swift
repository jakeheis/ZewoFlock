import Flock
import Foundation

public extension Flock {
    static let Zewo: [Task] = SystemdTasks(provider: VaporSystemd()).createTasks()
}

class VaporSystemd: SystemdProvider {
    let name = "Zewo"
    
    var serviceFilePath: String {
        return "/lib/systemd/system/\(namespace)@.service"
    }
    
    func start(on server: Server) throws {
        try executeForAllProcesses("start", on: server)
    }
    
    func stop(on server: Server) throws {
        try executeForAllProcesses("stop", on: server)
    }
    
    func restart(on server: Server) throws {
        try executeForAllProcesses("restart", on: server)
    }
    
    func status(on server: Server) throws {
        try executeForAllProcesses("status", on: server)
    }
    
    func executeForAllProcesses(_ command: String, on server: Server) throws {
        let count = try processCount(on: server)
        for i in 0 ..< count {
            try server.execute("service \(namespace)@\(i + 1) \(command)")
        }
    }
    
    func processCount(on server: Server) throws -> Int {
        if let coreCountOutput = try server.capture("nproc")?.trimmingCharacters(in: .whitespacesAndNewlines),
            let coreCount = Int(coreCountOutput) {
            return coreCount
        } else {
            return 1
        }
    }
    
}
