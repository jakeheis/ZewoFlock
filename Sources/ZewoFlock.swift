import Flock
import Foundation

public extension Flock {
    static let Zewo: [Task] = [
        StopTask(),
        StartTask(),
        ProcessTask()
    ]
}

let zewo = "zewo"

public class StopTask: Task {
    public let name = "stop"
    public let namespace = zewo
    public let hookTimes: [HookTime] = [.before("deploy:link")]
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            try server.execute("kill -9 \(pid)")
        } else {
            print("Zewo not running")
        }
    }
}

public class StartTask: Task {
    public let name = "start"
    public let namespace = zewo
    public let hookTimes: [HookTime] = [.after("deploy:link")]
    
    public func run(on server: Server) throws {
        print("Starting Zewo")
        try server.execute("nohup \(Paths.executable) > /dev/null 2>&1 &")
        try invoke("zewo:list")
    }
}

public class ProcessTask: Task {
    public let name = "process"
    public let namespace = zewo
    
    public func run(on server: Server) throws {
        if let pid = try findServerPid(on: server) {
            print("Zewo running as process \(pid)")
        } else {
            print("Zewo not running")
        }
    }
}

private func findServerPid(on server: Server) throws -> String? {
    guard let processes = try server.capture("ps aux | grep \".build\"") else {
        return nil
    }
    
    let lines = processes.components(separatedBy: "\n")
    for line in lines where !line.contains("grep") {
        let segments = line.components(separatedBy: " ").filter { !$0.isEmpty }
        if segments.count > 1 {
            return segments[1]
        }
        return segments.count > 1 ? segments[1] : nil
    }
    return nil
}
