//
//  NSString.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/13/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation

internal extension NSString {
    private var decimalNumberValue: NSDecimalNumber? {
        // NSDecimalNumber lets us better get out what is actually there.
        let number = NSDecimalNumber(string: self as String)
        return number
    }

    internal var unsignedIntegerValue: UInt? {
        // NSNumber's unsignedIntegerValue returns an "Int" instead of "UInt".
        return self.decimalNumberValue?.unsignedLongValue
    }

    internal var unsignedIntValue: UInt32? {
        return self.decimalNumberValue?.unsignedIntValue
    }

    internal var unsignedLongLongValue: UInt64? {
        return self.decimalNumberValue?.unsignedLongLongValue
    }
}