//
//  View.swift
//

import Cocoa



class View : NSView
{
    public var action : TurtleAction? = nil;

    var boundingBox : CGRect {
        get {
            if let action = self.action {
                let boxFinder = BoundingBoxFinder(at: Turtle.initialHome.location)

                Turtle(with: boxFinder).perform(action)

                return boxFinder.rect
            } else {
                return bounds
            }
        }
    }

    override func awakeFromNib()
    {
        action = .lindenmayer(system: .hilbert(), depth: 5);
    }

    override func draw(_ dirtyRect: NSRect)
    {
        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(CGColor.black)
            context.fill(bounds)

            if let action = self.action {
                let matrix = CGAffineTransform.fit(rect: boundingBox, in: bounds.insetBy(dx: 8, dy: 8))

                context.saveGState()
                context.concatenate(matrix)

                Turtle(with: context).perform(action)

                context.setStrokeColor(CGColor.white)
                context.setLineJoin(CGLineJoin.bevel)
                context.strokePath()

                context.restoreGState()
            }
        }
    }
}
