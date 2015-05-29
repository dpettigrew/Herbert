//
//  JSONTypes.swift
//  THGJSON
//
//  Created by Brandon Sneed on 4/13/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation

/**
Identifiable JSON Types
*/
public enum JSONType: String, Printable {
    case NullType = "Null"
    case StringType = "String"
    case BoolType = "Bool"
    case NumberType = "Number"
    case ArrayType = "Array"
    case DictionaryType = "Dictionary"
    case UnknownType = "Unknown"

    public var description: String {
        return rawValue
    }

}

extension JSON: Printable {

    // MARK: Printable compliance

    public var description: String {
        return "JSON: value = \(rawValue!), type = \(type)"
    }

    // MARK: Type checking

    /**
    Returns the high-level type of the value contained in this instance.
    */
    public var type: JSONType {
        switch rawValue {
        case is NSNull:
            return .NullType
        case is NSString:
            return .StringType
        case let value as NSNumber:
            let objcType = String.fromCString(value.objCType)!
            switch objcType {
            // same as @encode.. search the internets for it.
            case "c", "C":
                return .BoolType
            // we can't break out more types as uint64's get created with "d" ie: a double and
            // in general, relying on objCType on NSNumber isn't terribly reliable for determining types from JSON.
            default:
                return .NumberType
            }
        case is NSArray:
            return .ArrayType
        case is NSDictionary:
            return .DictionaryType

        default:
            return .UnknownType
        }
    }

    // MARK: "is" checks

    public var isNull: Bool {
        return rawValue is NSNull
    }

    public var isString: Bool {
        return rawValue is String
    }

    public var isArray: Bool {
        return rawValue is NSArray
    }

    public var isDictionary: Bool {
        return rawValue is NSDictionary
    }

    public var isBool: Bool {
        return type == .BoolType
    }

    public var isNumber: Bool {
        return type == .NumberType
    }

    // MARK: -- Accessors by type

    public func asNull() -> NSNull? {
        if let value = rawValue as? NSNull {
            return value
        }
        return nil
    }

    // MARK: Collection type conversion

    public func asArray() -> Array<AnyObject>? {
        var result: Array<AnyObject>? = nil
        switch rawValue {
        case let array as NSArray:
            result = JSON.decompose(array) as? Array<AnyObject>
        default:
            result = nil
        }

        return result
    }

    public func asArray<T: JSONModel>() -> Array<T>? {
        var result: Array<T>? = nil

        if let array = rawValue as? Array<AnyObject> {
            result = Array<T>()

            for i in 0..<array.count {
                let item = T(JSON.compose(array[i]))
                if let item = item {
                    result?.append(item)
                }
            }
        }

        return result
    }

    @objc
    public func asArray(aClass: AnyClass) -> NSArray? {
        return nil
    }
    
    public func asDictionary() -> Dictionary<String, AnyObject>? {
        var result: Dictionary<String, AnyObject>? = nil
        switch rawValue {
        case let dictionary as NSDictionary:
            result = JSON.decompose(dictionary) as? Dictionary<String, AnyObject>
        default:
            result = nil
        }

        return result
    }
    
    public func asDictionary<T: JSONModel>() -> Dictionary<String, T>? {
        var result: Dictionary<String, T>? = nil

        if let dictionary = rawValue as? Dictionary<String, AnyObject> {
            result = Dictionary<String, T>()
            for (key, value) in dictionary {
                let item = T(JSON.compose(value))
                if let item = item {
                    result?[key] = item
                }
            }
        }

        return result
    }
    
    // MARK: String conversion

    public func asString() -> String? {
        if let value = rawValue as? String {
            return value
        } else if type == .BoolType {
            if asBool()! {
                return "true"
            } else {
                return "false"
            }
        } else if let value = rawValue as? NSNumber {
            return value.stringValue
        }
        return nil
    }

    // MARK: Bool conversion

    public func asBool() -> Bool? {
        if let value = rawValue as? NSNumber {
            return value.boolValue
        } else if let value = rawValue as? NSString {
            return value.boolValue
        }
        return nil
    }

    // MARK: Int conversion

    public func asInt() -> Int? {
        if let value = rawValue as? NSNumber {
            return value.integerValue
        } else if let value = rawValue as? NSString {
            return value.integerValue
        }
        return nil
    }

    public func asInt32() -> Int32? {
        if let value = rawValue as? NSNumber {
            return value.intValue
        } else if let value = rawValue as? NSString {
            return value.intValue
        }
        return nil
    }

    public func asInt64() -> Int64? {
        if let value = rawValue as? NSNumber {
            return value.longLongValue
        } else if let value = rawValue as? NSString {
            return value.longLongValue
        }
        return nil
    }

    // MARK: UInt conversion

    public func asUInt() -> UInt? {
        if let value = rawValue as? NSNumber {
            // NSNumber's unsignedIntegerValue returns an "Int" instead of a "UInt".
            return value.unsignedLongValue
        } else if let value = rawValue as? NSString {
            return value.unsignedIntegerValue
        }
        return nil
    }

    public func asUInt32() -> UInt32? {
        if let value = rawValue as? NSNumber {
            return value.unsignedIntValue
        } else if let value = rawValue as? NSString {
            return value.unsignedIntValue
        }
        return nil
    }

    public func asUInt64() -> UInt64? {
        if let value = rawValue as? NSNumber {
            return value.unsignedLongLongValue
        } else if let value = rawValue as? NSString {
            return value.unsignedLongLongValue
        }
        return nil
    }

    // MARK: Decimal conversion

    public func asFloat() -> Float? {
        if let value = rawValue as? NSNumber {
            return value.floatValue
        } else if let value = rawValue as? NSString {
            return value.floatValue
        }
        return nil
    }

    public func asDouble() -> Double? {
        if let value = rawValue as? NSNumber {
            return value.doubleValue
        } else if let value = rawValue as? NSString {
            return value.doubleValue
        }
        return nil
    }

    public func asDecimalNumber() -> NSDecimalNumber? {
        if let value = rawValue as? NSDecimalNumber {
            // sometimes, NSJSONSerializer creates NSDecimalNumbers, so just return it.
            return value
        } else if let value = rawValue as? NSNumber {
            return NSDecimalNumber(decimal: value.decimalValue)
        } else if let value = rawValue as? String {
            return NSDecimalNumber(string: value)
        }
        return nil
    }
}