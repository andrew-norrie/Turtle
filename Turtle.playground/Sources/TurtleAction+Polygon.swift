//
//  TurtleAction+Polygon.swift
//

import Foundation
import QuartzCore


extension TurtleAction
{
    public static func polygon(sideLength: CGFloat, sideCount: Int, ccw direction: Bool = true) -> TurtleAction
    {
        let move = TurtleAction.move(by: sideLength)
        let turn = TurtleAction.turn(by: 360 / CGFloat(sideCount), ccw: direction)
        let shut = TurtleAction.shut()

        return .sequence([ .sequence([ move, turn ], repeat: sideCount-1), shut, turn ])
    }

    public static func spokedPolygon(sideLength: CGFloat, sideCount: Int) -> TurtleAction
    {
        let N = CGFloat(sideCount)
        let theta = CGFloat.pi / N
        let chord = 2 * sin(theta)

        let radius = sideLength / chord
        let center = CGPoint(x: sideLength / 2, y: radius * cos(theta))

        let move = TurtleAction.move(by: sideLength)
        let jump = TurtleAction.jump(by: sideLength)
        let turn = TurtleAction.turn(by: 360 / N)
        let shut = TurtleAction.shut()

        let stack = TurtleAction.stack()

        return .sequence([ .sequence([ .sequence([ move, turn ], repeat: sideCount-1), shut, turn ]),
                           .sequence([ stack.push,
                                       .move(by: center),
                                       stack.pull,
                                       jump,
                                       turn ], repeat: sideCount) ])
    }

    public static func polygon(sideLength: CGFloat, sideCount: Int, ccw direction: Bool = true, twist twistDeg: CGFloat, repeat count: Int) -> TurtleAction
    {
        func radians(_ degrees: CGFloat) -> CGFloat
        {
            return degrees * CGFloat.pi / 180
        }

        let N = CGFloat(sideCount)

        let theta = CGFloat.pi / N
        let twist = radians(twistDeg)

        var l = sideLength

        let move = TurtleAction(method: { (tommy: Turtle) in
            tommy.move(by: l);
        })

        let turn = TurtleAction.turn(by: 360 / N, ccw: direction)

        let open = TurtleAction(method: { (tommy: Turtle) in
            tommy.open();
        })

        let shut = TurtleAction.shut()

        let scaleFactor = cos(theta) / cos(1 * theta - twist)
        let shiftFactor = sin(2 * theta - twist) / sin(twist) + 1

        let next = TurtleAction(method: { (tommy: Turtle) in
            tommy.jump(by: l / shiftFactor);
            tommy.turn(by: twistDeg, ccw: direction);
            l *= scaleFactor;
        })

        let reset = TurtleAction(method: { (tommy: Turtle) in
            l = sideLength
        })

        let stack = TurtleAction.stack()

        let polygon = TurtleAction.sequence([ open, .sequence([ move, turn ], repeat: sideCount-1), shut, turn ])

        return TurtleAction.sequence([ stack.push, polygon, .sequence([next, polygon], repeat: count-1), reset, stack.pull ])
    }
}

