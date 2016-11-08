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
