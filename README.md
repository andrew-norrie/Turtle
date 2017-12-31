##  Turtle Graphics and Lindenmayer Systems Experiments

For information on [L-Systems](https://en.wikipedia.org/wiki/L-system) see [Lindenmayer Systems, Fractals, and Plants](http://algorithmicbotany.org/papers/#lsfp) or [The Algorithmic Beauty of Plants](http://algorithmicbotany.org/papers/#abop)

### Key Classes, Structs and Protocols

* [Turtle](Turtle.playground/Sources/Turtle.swift) - A class that holds a location, direction and a renderer object

* [TurtleAction](Turtle.playground/Sources/TurtleAction.swift) - A struct that wraps a closure of the form `(_ : Turtle) -> Void`. Actions are simple instructions like move or turn and complex sequences of other actions.

* [TurtleRenderer](Turtle.playground/Sources/TurtleRenderer.swift) - A protocol for renderers. There are two implementations. One is an [extentsion to CGContext](Turtle.playground/Sources/CGContext+TurtleRenderer.swift). The other is a [bounding box finder](Turtle.playground/Sources/BoundingBoxFinder.swift).

* TurtleView - A [NS](macOS/View.swift)/[UIView](Turtle.playground/Sources/TurtleView.swift) that holds a TurtleAction object and draws it scaled to the views bounds.

```swift
let flowsnake : TurtleAction = {
    let F = TurtleAction.move(by: 4)

    let x = [ "+" : TurtleAction.turn(by: +60),
              "-" : TurtleAction.turn(by: -60),
              "X" : F,
              "Y" : F ]

    let p = [ "X" : "X-Y--Y+X++XX+Y-",
              "Y" : "+X-YY--Y-X++X+Y" ]

    let a = "X"

    return .lindenmayer(axiom: a, rules: p, actions: x, depth: 4)
}()

let view = TurtleView(action: flowsnake)
```

![Picture of flowsnake](Images/IMG_0256.PNG?raw=true)

```swift
let triangles = (1 ... 3).map({ (i : Int) -> TurtleAction in
    if (i % 2 == 1) {
        return .polygon(sideLength: 150, sideCount: 3, ccw: (i == 1), twist: 3, repeat: 50)
    } else {
        return .turn(by: 60)
    }
})

let view = TurtleView(action: .sequence(triangles, repeat: 6))
```

![Picture of hexagon](Images/IMG_0257.PNG?raw=true)


### Requirements

Swift 4
Xcode 9 or Swift Playgrounds iPad app
