//
//  JSONData.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/20/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation

extension JSON {

    /**
    Returns a JSON encoded string representing this instance.
    :param: pretty Determines whether output will be pretty-printed.
    */
    public func asJSONString(pretty: Bool = false) -> String? {
        
        // Use asJSONData to convert to the proper NSData format
        if let data: NSData = asJSONData(pretty: pretty) {
            return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        }

        return nil
    }

    /**
    Returns a JSON encoded NSData representing this instance.
    :param: pretty Determines whether output will be pretty-printed.
    */
    public func asJSONData(pretty: Bool = false) -> NSData? {
        var options = NSJSONWritingOptions.allZeros
        if pretty {
            options = NSJSONWritingOptions.PrettyPrinted
        }

        if self.rawValue is NSArray {
            let object: NSArray? = JSON.decompose(self) as? NSArray
            if let object = object {
                var error: NSError? = nil
                if let data: NSData = NSJSONSerialization.dataWithJSONObject(object, options: options, error: &error) {
                    return data
                }
            }
        } else if self.rawValue is NSDictionary {
            let object: NSDictionary? = JSON.decompose(self) as? NSDictionary
            if let object = object {
                var error: NSError? = nil
                if let data: NSData = NSJSONSerialization.dataWithJSONObject(object, options: options, error: &error) {
                    return data
                }
            }
        }

        return nil
    }
    
}