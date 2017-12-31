//
//  TurtleBoundingBoxFinder.swift
//


import Foundation
import QuartzCore


public class BoundingBoxFinder : TurtleRenderer
{
    public var rect : CGRect {
        get { return CGRect(origin: CGPoint(x: minX, y: minY), size: CGSize(width: maxX - minX, height: maxY - minY)) }
    }

    public func move(to position: CGPoint)
    {
        update(with: position)
    }

    public func line(to position: CGPoint)
    {
        update(with: position)
    }

    public func shut() { }

    var minX : CGFloat
    var minY : CGFloat

    var maxX : CGFloat
    var maxY : CGFloat

    func update(with position: CGPoint)
    {
        if(position.x < minX) {
            minX = position.x
        } else

        if(position.x > maxX) {
            maxX = position.x
        }

        if(position.y < minY) {
            minY = position.y
        } else

        if(position.y > maxY) {
            maxY = position.y
        }
    }

    public init(at point: CGPoint = CGPoint(x: 0, y:0), size: CGFloat = 0)
    {
        minX = point.x - size / 2
        minY = point.y - size / 2
        maxX = point.x + size / 2
        maxY = point.y + size / 2
    }
}


extension TurtleAction
{
    public func boundingBox(at heading: Bearing = Turtle.initialHome) -> CGRect
    {
        let boxFinder = BoundingBoxFinder(at: heading.location)
        let action = self

        Turtle(at: heading, with: boxFinder).perform(action)

        return boxFinder.rect
    }
}
