//
//  CGContext+TurtleRenderer.swift
//
//

import QuartzCore


extension CGContext : TurtleRenderer
{
    public func line(to position: CGPoint)
    {
        addLine(to: position)
    }

    public func shut()
    {
        closePath()
        strokePath()
    }
}
