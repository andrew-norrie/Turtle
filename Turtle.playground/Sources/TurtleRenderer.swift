//
//  TurtleRenderer.swift
//


import QuartzCore


public protocol TurtleRenderer
{
    /// Move to a given point without drawing
    ///
    /// - Parameter position: The location to move to
    func move(to position: CGPoint)

    /// Move to a given point drawing a line from the current location.
    ///
    /// - Parameter position: The location to move to
    func line(to position: CGPoint)

    /// Move to the position specified in the most recent call to
    /// the move function drawing a line from the current location.
    func shut()
}
