//
//  TurtleAction.swift
//


import Foundation
import QuartzCore


public struct TurtleAction
{
    let method : ((_ : Turtle) -> Void)

    public init(method : @escaping ((_ : Turtle) -> Void))
    {
        self.method = method;
    }

    /// Make an action that turns the turtle
    ///
    /// - Parameters:
    ///   - degrees: The amount to turn
    ///   - ccw: Optional argument specifying if the positive
    ///     direction is counter-clockwise. Default is true.
    ///
    /// - Returns: A TurtleAction implementing the specified turn
    public static func turn(by degrees: CGFloat, ccw: Bool = true) -> TurtleAction
    {
        let amount = ccw ? degrees : 0 - degrees;

        func command(tommy : Turtle) {
            tommy.turn(by: amount)
        }

        return TurtleAction(method: command);
    }

    /// Make an action to move the turtle without drawing
    ///
    /// - Parameter heading: A vector relative to the bearing
    ///   of the turtle.  The X component is in the direction
    ///   that the turtle is facing. The Y component is othoganal
    ///
    /// - Returns: A TurtleAction implementing the specified move
    public static func jump(by heading: CGPoint = CGPoint(x: 1, y:0)) -> TurtleAction
    {
        func command(tommy : Turtle) {
            tommy.jump(by: heading);
        }

        return TurtleAction(method: command);
    }

    /// Make an action to move the turtle without drawing
    ///
    /// - Parameter distance: Amount to move in the direction that
    ///   the turtle is facing
    ///
    /// - Returns: A TurtleAction implementing the specified move
    public static func jump(by distance: CGFloat = 1) -> TurtleAction
    {
        return jump(by: CGPoint(x: distance, y:0))
    }


    /// Make an action to move the turtle drawing a line
    ///
    /// - Parameter heading: A vector relative to the bearing
    ///   of the turtle.  The X component is in the direction
    ///   that the turtle is facing. The Y component is othoganal
    ///
    /// - Returns: A TurtleAction implementing the specified move
    public static func move(by heading: CGPoint = CGPoint(x: 1, y:0)) -> TurtleAction
    {
        func command(tommy : Turtle) {
            tommy.move(by: heading);
        }

        return TurtleAction(method: command);
    }

    /// Make an action to move the turtle drawing a line
    ///
    /// - Parameter distance: Amount to move in the direction that
    ///   the turtle is facing
    ///
    /// - Returns: A TurtleAction implementing the specified move
    public static func move(by distance: CGFloat = 1) -> TurtleAction
    {
        return move(by: CGPoint(x: distance, y:0))
    }

    /// Make an action that begins a new polygon
    ///
    /// - Returns: A TurtleAction that marks the start of polygon
    public static func open() -> TurtleAction
    {
        func command(tommy : Turtle) {
            tommy.open();
        }

        return TurtleAction(method: command);
    }

    /// Make an action that completes a polygon
    ///
    /// - Returns: A TurtleAction that shuts the polygon
    public static func shut() -> TurtleAction
    {
        func command(tommy : Turtle) {
            tommy.shut();
        }

        return TurtleAction(method: command);
    }

    /// Make an action that is a sequence of actions
    ///
    /// - Parameters:
    ///   - list: An array of TurtleAction objects
    ///   - count: The number of times to repeat the
    ///     sequence each time. Default is one.
    ///
    /// - Returns: A TurtleAction that wraps a sequence of other actions
    public static func sequence(_ list: [TurtleAction], repeat count: Int = 1) -> TurtleAction
    {
        func command(tommy : Turtle) {
            var n = count

            while(0 < n) {
                tommy.perform(list);
                n = n - 1;
            }
        }

        return TurtleAction(method: command);
    }

    /// Make a stack to hold turtle bearings.
    ///
    /// - Returns: A tuple containing a pair TurtleActions, push and pull,
    ///   that operate on a common stack
    public static func stack() -> (push: TurtleAction, pull: TurtleAction)
    {
        class cons {
            let car : Bearing
            let cdr : cons?

            init(car item: Bearing, cdr list: cons?)
            {
                car = item
                cdr = list
            }
        }

        var list : cons? = nil;

        func push(tommy : Turtle) {
            list = cons(car: tommy.tack, cdr: list);
        }

        func pull(tommy : Turtle) {
            if let cons = list {
                tommy.jump(to: cons.car)
                list = cons.cdr;
            }
        }

        return (TurtleAction(method: push), TurtleAction(method: pull))
    }
}


extension Turtle
{
    public func perform<T: Sequence>(_ sequence: T) where T.Element == TurtleAction
    {
        for action in sequence {
            perform(action);
        }
    }

    public func perform(_ action: TurtleAction)
    {
        action.method(self);
    }
}
