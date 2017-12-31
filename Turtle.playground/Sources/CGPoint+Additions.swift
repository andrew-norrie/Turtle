//
//  CGPoint+Additions.swift
//


import QuartzCore


extension CGPoint
{
    static func + (a: CGPoint, b: CGPoint) -> CGPoint
    {
        return CGPoint(x: a.x + b.x, y: a.y + b.y)
    }

    static func - (a: CGPoint, b: CGPoint) -> CGPoint
    {
        return CGPoint(x: a.x - b.x, y: a.y - b.y)
    }
}

