import Flock

public extension Flock {
    static let Zewo: [Task] = SystemdTasks(provider: ZewoSystemd()).createTasks()
}

class ZewoSystemd: SystemdProvider {
    let name = "zewo"
    let serviceName = "zewo"
}
