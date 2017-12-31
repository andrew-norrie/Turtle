//
//  Turtle.swift
//

import Foundation
import QuartzCore


public struct Bearing
{
    var location : CGPoint
    var orientation : CGFloat;

    var radians : CGFloat { get { return orientation * CGFloat.pi / 180 } }

    init(at location: CGPoint, facing direction: CGFloat)
    {
        self.location = location;
        self.orientation = direction;
    }

    mutating func turn(by degrees: CGFloat)
    {
        orientation += degrees;
    }

    mutating func move(by heading: CGPoint = CGPoint(x: 1, y:0))
    {
        location = location + heading.applying(CGAffineTransform(rotationAngle: radians));
    }

    mutating func move(to here: CGPoint, facing direction: CGFloat)
    {
        location = here
        orientation = direction
    }
}


public class Turtle
{
    public static var initialHome : Bearing {
        get { return Bearing(at: CGPoint(x: 0, y:0), facing: 90) }
    }

    public var context : TurtleRenderer

    public var tack : Bearing
    public var savedHome : Bearing

    var start : CGPoint

    convenience init(at location: CGPoint, heading direction: CGFloat, with context: TurtleRenderer)
    {
        self.init(at: Bearing(at: location, facing: direction), with: context);
    }

    public init(at heading: Bearing = Turtle.initialHome, with context: TurtleRenderer)
    {
        self.context = context;

        tack = heading;
        savedHome = tack;
        start = tack.location
        context.move(to: start)
    }

    public func turn(by degrees: CGFloat, ccw: Bool = true)
    {
        tack.turn(by: ccw ? degrees : 0  - degrees);
    }

    public func move(by heading: CGPoint = CGPoint(x: 1, y:0))
    {
        tack.move(by: heading);
        context.line(to: tack.location)
    }

    public func move(by distance: CGFloat)
    {
        move(by: CGPoint(x: distance, y:0))
    }

    public func jump(by heading: CGPoint = CGPoint(x: 1, y:0))
    {
        tack.move(by: heading);
        start = tack.location
        context.move(to: start);
    }

    public func jump(by distance: CGFloat)
    {
        jump(by: CGPoint(x: distance, y:0))
    }

    public func jump(to here: Bearing)
    {
        tack = here;
        start = tack.location
        context.move(to: start);
    }

    public func zero()
    {
        savedHome = tack
    }

    public func home()
    {
        jump(to: savedHome)
    }

    public func open()
    {
        start = tack.location
        context.move(to: start);
    }

    public func shut()
    {
        if tack.location.x != start.x || tack.location.y != start.y {
            let vector = start - tack.location
            tack.move(to: start, facing: 180 * atan2(vector.y, vector.x) / CGFloat.pi)
        }

        context.shut();
    }
}
