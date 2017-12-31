//: Turtle Graphics and Lindenmayer System playground

import PlaygroundSupport
import QuartzCore


TurtleView.defaultSize = CGSize(width: 700, height: 700)


let hilbert = TurtleView(action: .lindenmayer(system: .hilbert(), depth: 5))


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


PlaygroundSupport.PlaygroundPage.current.liveView = view

