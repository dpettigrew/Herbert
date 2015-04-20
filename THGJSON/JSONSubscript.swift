//
//  JSONSubscript.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/12/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation
import THGLog

extension JSON {

    public subscript(index: Int) -> JSON? {
        switch rawValue {
        case let array as NSArray:
            if (index >= 0) && (index < array.count) {
                return JSON(object: array[index])
            }
        default:
            log(.Debug, "You asked for an index on a JSON object that isn't an array!")
        }

        return nil
    }

    public subscript(key: String) -> JSON? {
        switch rawValue {
        case let dictionary as NSDictionary:
            if let value: AnyObject = dictionary[key] {
                return JSON(object: value)
            }
        default:
            log(.Debug, "You asked for a value on a JSON object that isn't a dictionary!")
        }

        return nil
    }

}