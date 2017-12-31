//
//  TurtleView.swift
//

import UIKit

public class TurtleView : UIView
{
    public static var defaultSize = CGSize(width:240, height:320)

    public var action : TurtleAction? = nil;

    public convenience init?(action: TurtleAction)
    {
        self.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: TurtleView.defaultSize), action: action)
    }

    public init?(frame: CGRect, action: TurtleAction)
    {
        super.init(frame: frame)

        self.action = action
    }

    public required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }


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

    override public func draw(_ rect: CGRect)
    {
        if let context = UIGraphicsGetCurrentContext() {
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

                Turtle(with: context).perform(action)

                context.restoreGState()
            }
        }
    }
}
