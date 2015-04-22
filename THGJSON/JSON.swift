//
//  JSON.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/9/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation
import THGLog

/**
A classy class to make handling JSON simpler.
*/
public class JSON {

    /**
    Initialize an instance given an NSData containing JSON.
    */
    public init?(data: NSData?) {
        if let data = data {
            var error: NSError? = nil
            if let object: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) {
                rawValue = JSON.decompose(object)
                // you'd think this would be 'return self', but self is implied in failable init's.
                return
            } else {
                log(.Error, "Unable to deserialize this instance of NSData!")
            }
        }

        rawValue = nil
        return nil
    }

    /**
    Initialize an instance given a collection type.

    :param: object A collection, NSArray, Dictionary, etc.
    */
    public init?(object: AnyObject) {
        rawValue = JSON.decompose(object)
        if rawValue == nil {
            log(.Error, "Unable to decompose object.")
            return nil
        }
    }

    /**
    Initialize an instance given a JSON string.
    
    :param: string A string containing JSON data.
    */
    public convenience init?(string: String) {
        self.init(data: string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false))
    }

    /**
    Accessor for the rawValue associated with this instance.
    */
    public let rawValue: AnyObject?

    internal class func decompose(object: AnyObject) -> AnyObject {
        switch object {
        case let array as NSArray:
            var newArray = Array<AnyObject>()
            for item in array {
                newArray.append(JSON.decompose(item))
            }
            return newArray

        case let dictionary as NSDictionary:
            var newDictionary = Dictionary<String, AnyObject>()
            for (key, value) in dictionary {
                if let key = key as? String {
                    newDictionary[key] = JSON.decompose(value)
                }
            }
            return newDictionary

        case let json as JSON:
            return json.rawValue!

        default:
            return object
        }
    }

}