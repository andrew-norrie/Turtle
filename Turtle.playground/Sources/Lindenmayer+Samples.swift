//
//  Lindenmayer+Samples.swift
//


import Foundation
import QuartzCore

extension Lindenmayer where SymbolList == [String]
{
    public static func dragon(scale: CGFloat = 4) -> Lindenmayer
    {
        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: 1 * scale) ]

        let p = [ "X" : "X+YF+",
                  "Y" : "-FX-Y" ]

        let a = "FX"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func flowSnake(scale: CGFloat = 4) -> Lindenmayer
    {
        let F = TurtleAction.move(by: 1 * scale);

        let x = [ "+" : TurtleAction.turn(by: +60),
                  "-" : TurtleAction.turn(by: -60),
                  "X" : F,
                  "Y" : F ]

        let p = [ "X" : "X-Y--Y+X++XX+Y-",
                  "Y" : "+X-YY--Y-X++X+Y" ]

        let a = "X"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func hilbert(scale: CGFloat = 4) -> Lindenmayer
    {
        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: 1 * scale) ]

        let p = [ "X" : "-YF+XFX+FY-",
                  "Y" : "+XF-YFY-FX+" ]

        let a = "X"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }


    public static func peano(scale: CGFloat = 4) -> Lindenmayer
    {
        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: 1 * scale) ]

        let p = [ "X" : "XFYFX+F+YFXFY-F-XFYFX",
                  "Y" : "YFXFY-F-XFYFX+F+YFXFY" ]

        let a = "X"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }


    public static func sierpinski1912(scale: CGFloat = 4) -> Lindenmayer
    {
        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: 1 * scale) ]

        let p = [ "X" : "XF−F+F−XF+F+XF−F+F−X" ]

        let a = "F+XF+F+XF"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }


    public static func quadraticGosper(scale: CGFloat = 4) -> Lindenmayer
    {
        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: 1 * scale) ]

        let p = [ "X" : "XFX-YF-YF+FX+FX-YF-YFFX+YF+FXFXYF-FX+YF+FXFX+YF-FXYF-YF-FX+FX+YFYF-",
                  "Y" : "+FXFX-YF-YF+FX+FXYF+FX-YFYF-FX-YF+FXYFYF-FX-YFFX+FX+YF-YF-FX+FX+YFY" ]

        let a = "-YF"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func sierpinskiTriangle(scale: CGFloat = 12) -> Lindenmayer
    {
        let F = TurtleAction.move(by: 1 * scale);

        let x = [ "+" : TurtleAction.turn(by: +120),
                  "-" : TurtleAction.turn(by: -120),
                  "X" : F,
                  "Y" : F ]


        let p = [ "X" : "X-Y+X+Y-X",
                  "Y" : "YY" ]

        let a = "X-Y-Y"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func kristall(scale: CGFloat = 12) -> Lindenmayer
    {
        let v = CGPoint(x:1 * scale, y:0)

        let x = [ "+" : TurtleAction.turn(by: +90),
                  "-" : TurtleAction.turn(by: -90),
                  "F" : TurtleAction.move(by: v),
                  "f" : TurtleAction.jump(by: v) ]

        let p = [ "F" : "F+F--f+F-F++f-F",
                  "f" : "fff" ]

        let a = "F"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func plant(scale: CGFloat = 12) -> Lindenmayer
    {
        let stack = TurtleAction.stack()

        let x = [ "+" : TurtleAction.turn(by: +25),
                  "-" : TurtleAction.turn(by: -25),
                  "F" : TurtleAction.move(by: 1 * scale),
                  "[" : stack.push,
                  "]" : stack.pull]

        let p = [ "X" : "F-[[X]+X]+F[+FX]-X",
                  "F" : "FF" ]

        let a = "X"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func penrose(scale: CGFloat = 12) -> Lindenmayer
    {
        let stack = TurtleAction.stack()

        let x = [ "+" : TurtleAction.turn(by: +36),
                  "-" : TurtleAction.turn(by: -36),
                  "F" : TurtleAction.move(by: 1 * scale),
                  "[" : stack.push,
                  "]" : stack.pull]

        let p = [ "Y" : "xF++yF----XF[-xF----YF]++",
                  "X" : "+xF--yF[---YF--XF]+",
                  "x" : "-YF++XF[+++xF++yF]-",
                  "y" : "--xF++++YF[+yF++++XF]--XF",
                  "F" : "" ]

        let a = "[X]++[X]++[X]++[X]++[X]"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func flake(scale: CGFloat = 7) -> Lindenmayer
    {
        var value = false

        func flipper() -> Bool {
            value = value == false;
            return value;
        }

        let polygon = TurtleAction(method: { (tommy: Turtle) in
            let action = TurtleAction.polygon(sideLength: scale, sideCount: 3, ccw: flipper(), twist: 60, repeat: 2)

            tommy.perform(action)
        })

        let F = TurtleAction.sequence([ polygon, .jump(by: scale) ])

        let x = [ "+" : TurtleAction.turn(by: +60),
                  "-" : TurtleAction.turn(by: -60),
                  "X" : F,
                  "Y" : F ]

        let p = [ "X" : "X-Y--Y+X++XX+Y-",
                  "Y" : "+X-YY--Y-X++X+Y" ]

        let a = "X"

        return Lindenmayer(axiom: a, rules: p, actions: x)
    }
}
