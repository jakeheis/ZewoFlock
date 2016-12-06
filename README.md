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

Flock.use(Flock.Deploy)
Flock.use(Flock.Zewo)
// Remove `Flock.use(Flock.Server)`
```
# Tasks
```
zewo:restart  # Hooks .after("deploy:link")
zewo:stop
zewo:start    
zewo:status
```
`ZewoFlock` hooks into the deploy process to automatically restart the server after the new release is built, so you should never have to call these tasks directly.
# Configuration
```swift
public extension Config {
    // Default value; resolved by Supervisord to something like /var/log/supervisor/zewo-0.out
    static var outputLog = "/var/log/supervisor/%%(program_name)s-%%(process_num)s.out"
    
    // Default value; resolved by Supervisord to something like /var/log/supervisor/zewo-0.err
    static var errorLog = "/var/log/supervisor/%%(program_name)s-%%(process_num)s.err"
}
```
In order to ensure logging works correctly, you'll likely want to turn off output bufferring in `main.swift`:
```swift
#if os(Linux)
import Glibc
#else
import Darwin
#endif

import HTTPServer

setbuf(stdout, nil)
setbuf(stderr, nil)

let router = BasicRouter { route in
...
```
