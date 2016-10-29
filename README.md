# ZewoFlock

Automated deployment of your [Zewo](https://github.com/Zewo/Zewo) server using [Flock](https://github.com/jakeheis/Flock).

# Installation
Add these lines to `deploy/FlockDependencies.json`:
```
"dependencies" : [
       ...
       {
           "url" : "https://github.com/jakeheis/ZewoFlock",
           "version": "0.0.1"
       }
]
```
In your `Flockfile` add:
```swift
import Flock
import ZewoFlock

...

Flock.use(Flock.Zewo)
```
# Config
These fields are open for customization in your `config/deploy/Always.swift` and related configuration files:
```swift
public extension Config {
    static var outputLog = "/dev/null"
    static var errorLog = "/dev/null"
}
```
If you set these variable to anything other than `/dev/null`, you'll likely want to turn off stdout bufferring to ensure log files are properly written to:
```swift
// Sources/main.swift

#if os(Linux)
import Glibc
#else
import Darwin
#endif
import HTTPServer

setbuf(stdout, nil)

let router = BasicRouter { route in
...
```
# Tasks
```
zewo:stop     # Hooks .before("deploy:link")
zewo:start    # Hooks .after("deploy:link")
zewo:ps
```
`ZewoFlock` hooks into the deploy process to automatically restart the server after the new release is built, so you should never have to call these tasks directly.
