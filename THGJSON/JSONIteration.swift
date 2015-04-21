//
//  JSONIteration.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/20/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation

extension JSON: SequenceType {

    public func generate() -> GeneratorOf<(AnyObject, JSON)> {
        switch rawValue {
        case let dictionary as NSDictionary:
            var generator = dictionary.generate()

            return GeneratorOf<(AnyObject, JSON)> {
                if let (key: AnyObject, value: AnyObject) = generator.next() {
                    return (key, JSON(object: value)!)
                }
                return nil
            }

        case let array as NSArray:
            var generator = enumerate(array).generate()

            return GeneratorOf<(AnyObject, JSON)> {
                if let (index: Int, element: AnyObject) = generator.next() {
                    return (index, JSON(object: element)!)
                }
                return nil
            }

        default:
            return GeneratorOf<(AnyObject, JSON)> {
                return nil
            }
        }
    }

}
