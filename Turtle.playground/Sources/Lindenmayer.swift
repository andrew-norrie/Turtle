//
//  Lindenmayer.swift
//

import Foundation
import QuartzCore

public struct Lindenmayer<SymbolList : Sequence> where SymbolList.Element : Hashable
{
    typealias Symbol = SymbolList.Element

    let axiom : SymbolList

    let rules : [Symbol : SymbolList]

    let actions : [Symbol : TurtleAction]

    public func process(list: SymbolList, depth: Int, with tommy: Turtle)
    {
        for s in list {
            if let rule = depth < 1 ? nil : rules[s] {
                process(list: rule, depth: depth - 1, with: tommy)
            } else

            if let action = actions[s] {
                tommy.perform(action)
            }
        }
    }

    public func process(depth n: Int, with tommy: Turtle)
    {
        process(list: axiom, depth: n, with: tommy)
    }
}


extension Lindenmayer
{
    public func boundingBox(at heading: Bearing = Turtle.initialHome, depth n: Int) -> CGRect
    {
        let boxFinder = BoundingBoxFinder(at: heading.location)

        process(depth: n, with: Turtle(at: heading, with: boxFinder))

        return boxFinder.rect
    }
}


extension Lindenmayer where SymbolList == [String]
{
    public static func stringArrayFromCharacters(_ s : String) -> [String]
    {
        return Array(s.indices.map { (i: String.Index) -> String in
            return String(s[i])
        })
    }


    public init(axiom: String, rules: [String : String], actions unchanged: [String : TurtleAction], split: ((String) -> [String]) = Lindenmayer.stringArrayFromCharacters)
    {
        let p = Dictionary(uniqueKeysWithValues: rules.map { (key: String, value: String) -> (String,[String]) in
            return (key, split(value))
        })

        let a = split(axiom)

        self.init(axiom: a, rules: p, actions: unchanged)
    }
}


extension TurtleAction
{
    public static func lindenmayer<T>(system : Lindenmayer<T>, depth n: Int) -> TurtleAction
    {
        func command(tommy : Turtle) {
            system.process(depth: n, with: tommy)
        }

        return TurtleAction(method: command);
    }
}


extension TurtleAction
{
    public static func lindenmayer(axiom a: String, rules p: [String : String], actions x: [String : TurtleAction], depth n: Int) -> TurtleAction
    {
        return lindenmayer(system: Lindenmayer<[String]>(axiom: a, rules: p, actions: x), depth: n);
    }
}
