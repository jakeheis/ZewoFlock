import Flock
import Foundation

public extension Flock {
    static let Zewo: [Task] = [
        StopTask(),
        StartTask(),
        PsTask()
    ]
}

public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}

let zewo = "zewo"

public class StopTask: Task {
    public let name = "stop"
    public let namespace = zewo
    public let hookTimes: [HookTime] = [.before("deploy:link")]
    
    public func run(on server: Server) throws {
        let pids = try findServerPids(on: server)
        guard !pids.isEmpty else {
            print("Zewo not running")
            return
        }
        
        for pid in pids {
            try server.execute("kill -9 \(pid)")
        }
    }
}

public class StartTask: Task {
    public let name = "start"
    public let namespace = zewo
    public let hookTimes: [HookTime] = [.after("deploy:link")]
    
    public func run(on server: Server) throws {
        print("Starting Zewo")
        let coreCount: Int
        if let coreCountOutput = try server.capture("nproc") {
            coreCount = Int(coreCountOutput) ?? 1
        } else {
            coreCount = 1
        }
        for _ in 0 ..< coreCount {
            try server.execute("nohup \(Paths.executable) >> \(Config.outputLog) 2>> \(Config.errorLog) &")
        }
        try invoke("zewo:ps")
    }
}

public class PsTask: Task {
    public let name = "ps"
    public let namespace = zewo
    
    public func run(on server: Server) throws {
        let pids = try findServerPids(on: server)
        if pids.isEmpty {
            print("Zewo not running")
        } else {
            for pid in pids {
                print("Zewo running as process \(pid)")
            }
        }
    }
}

private func findServerPids(on server: Server) throws -> [String] {
    guard let processes = try server.capture("ps aux | grep \".build\"") else {
        return []
    }
    
    var pids: [String] = []
    
    let lines = processes.components(separatedBy: "\n")
    for line in lines where !line.contains("grep") {
        let segments = line.components(separatedBy: " ").filter { !$0.isEmpty }
        if segments.count > 1 {
            pids.append(segments[1])
        }
    }
    
    return pids
}
