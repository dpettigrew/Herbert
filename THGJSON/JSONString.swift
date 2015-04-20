//
//  JSONString.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/20/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation

extension JSON {

    public func asJSONString() -> String? {
        if self.rawValue is NSArray {
            let object: NSArray? = JSON.decompose(self) as? NSArray
            if let object = object {
                var error: NSError? = nil
                if let data: NSData = NSJSONSerialization.dataWithJSONObject(object, options: nil, error: &error) {
                    return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                }
            }
        } else if self.rawValue is NSDictionary {
            let object: NSDictionary? = JSON.decompose(self) as? NSDictionary
            if let object = object {
                var error: NSError? = nil
                if let data: NSData = NSJSONSerialization.dataWithJSONObject(object, options: nil, error: &error) {
                    return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                }
            }
        }

        return nil
    }

}