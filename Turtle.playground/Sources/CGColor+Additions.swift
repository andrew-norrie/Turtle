//
//  CGColor+Additions.swift
//  Spinner iOS
//
//  Created by Andrew Norrie on 12/12/17.
//

import QuartzCore


func Color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> CGColor
{
    guard let color = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [red, green, blue, alpha]) else { abort() }

    return color
}


let White = Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5);
let Red = Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0);
let Black = Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);


extension CGColor
{
    public static var red : CGColor { get { return Red } }
    public static var white : CGColor { get { return White } }
    public static var black : CGColor { get { return Black } }
}
