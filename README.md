# ZewoFlock

Automated deployment of your [Zewo](https://github.com/Zewo/Zewo) server using [Flock](https://github.com/jakeheis/Flock).

## Installation
Add these lines to `deploy/FlockDependencies.json`:
```
"dependencies" : [
  ...
  {
    "name" : "https://github.com/jakeheis/ZewoFlock",
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
## Included tasks
```
zewo:stop     # Hooks .before("deploy:link")
zewo:start    # Hooks .after("deploy:link")
zewo:ps
```
