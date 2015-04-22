//
//  THGJSONTests.swift
//  THGJSONTests
//
//  Created by Brandon Sneed on 4/9/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import UIKit
import XCTest
import THGJSON

class THGJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

    func testInitWithBadJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_bad.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                // we got a valid json object
                XCTAssert(1 == 1, "Why in the hell did we get a valid json object for something that doesn't exist??")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }
    
    func testInitWithSimpleJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_simple.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                // we got a valid json object
                XCTAssert(json.rawValue is NSDictionary, "The JSON parsed wasn't an NSDictionary!")
            } else {
                XCTAssert(1 == 1, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testInitWithArrayOnlyJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_array.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                // we got a valid json object
                XCTAssert(json.rawValue is NSArray, "The JSON parsed wasn't an NSArray!")
                XCTAssert((json.rawValue as! NSArray).count == 6, "There were supposed to be 6 items in this array, 4 ITEMS!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testDictionaryJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_dictionary.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                // we got a valid json object
                let name = json["name"]?.asString
                let attr2 = json["attrs"]?[1]?.asString
                let bestBud = json["friends"]?[1]?["name"]?.asString
                let dirtIndex = json["dirtIndex"]?.asDouble

                XCTAssert(name == "Dennis", "The name should've been Dennis!")
                XCTAssert(attr2 == "ugly", "Attr2 should've been ugly!")
                XCTAssert(bestBud == "Arthur", "BestBud should've been Arthur!")
                XCTAssert(dirtIndex == 3.14, "DirtIndex should've been 3.14!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testBasicAccessorsJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_accessors.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {

                let null = json["null"]
                let isNull = null!.isNull
                XCTAssertTrue(null?.type == .NullType && isNull, "null isn't an NSNull!")

                let string = json["string"]
                let isString = string!.isString
                let stringAsString = string?.asString
                XCTAssertTrue(string?.type == .StringType && isString, "converted values failed check!")
                XCTAssertTrue(stringAsString! == "a string", "converted values don't match!")

                let stringNumber = json["stringNumber"]
                let isStringNumber = stringNumber!.isString
                let stringAsNumber = stringNumber?.asInt
                XCTAssertTrue(stringNumber?.type == .StringType && isStringNumber, "converted values failed check!")
                XCTAssertTrue(stringAsNumber! == 1234, "converted values don't match!")

                let bool = json["bool"]
                let isBool = bool!.isBool
                let boolAsString = bool?.asString
                XCTAssertTrue(bool?.type == .BoolType && isBool, "converted values failed check!")
                XCTAssertTrue(boolAsString! == "true", "converted values don't match!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testNumericalAccessorsJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_accessors.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {

                let int = json["int"]
                let isInt = int!.isNumber
                let intAsString = int?.asString
                XCTAssertTrue(int?.type == .NumberType && isInt && int?.asInt == -1234, "converted values failed check!")
                XCTAssertTrue(intAsString! == NSNumber(long: -1234).stringValue, "converted values don't match!")

                let int32 = json["int32"]
                let isInt32 = int32!.isNumber
                let int32AsString = int32?.asString
                XCTAssertTrue(int32?.type == .NumberType && isInt32 && int32?.asInt32 == -2147483647, "converted values failed check!")
                XCTAssertTrue(int32AsString! == NSNumber(int: -2147483647).stringValue, "converted values don't match!")

                let int64 = json["int64"]
                let isInt64 = int64!.isNumber
                let int64AsString = int64?.asString
                XCTAssertTrue(int64?.type == .NumberType && isInt64 && int64?.asInt == -9223372036854775807, "converted values failed check!")
                XCTAssertTrue(int64AsString! == NSNumber(longLong: -9223372036854775807).stringValue, "converted values don't match!")

                let uint = json["uint"]
                let isuInt = uint!.isNumber
                let uintAsString = uint?.asString
                XCTAssertTrue(uint?.type == .NumberType && isuInt && uint?.asUInt == 4294967295, "converted values failed check!")
                XCTAssertTrue(uintAsString! == NSNumber(unsignedLong: 4294967295).stringValue, "converted values don't match!")

                let uint32 = json["uint32"]
                let isuInt32 = uint32!.isNumber
                let uint32AsString = uint32?.asString
                XCTAssertTrue(uint32?.type == .NumberType && isuInt32 && uint32?.asUInt32 == 4294967295, "converted values failed check!")
                XCTAssertTrue(uint32AsString! == NSNumber(unsignedInt: 4294967295).stringValue, "converted values don't match!")

                let uint64 = json["uint64"]
                let isuInt64 = uint64!.isNumber
                let uint64AsString = uint64?.asString
                XCTAssertTrue(uint64?.type == .NumberType && isuInt64 && uint64?.asUInt64 == 18446744073709551615, "converted values failed check!")
                XCTAssertTrue(uint64AsString! == NSNumber(unsignedLongLong: 18446744073709551615).stringValue, "converted values don't match!")
                
                let float = json["float"]
                let isFloat = float!.isNumber
                let floatAsString = float?.asString
                XCTAssertTrue(float?.type == .NumberType && isFloat && float?.asFloat == 0.08251977, "converted values failed check!")
                // NSJSONSerialization will pull this in as a double even if it's below the threshold for being a float
                XCTAssertTrue(floatAsString! == NSNumber(double: 0.08251977).stringValue, "converted values don't match!")

                let double = json["double"]
                let isDouble = double!.isNumber
                let doubleAsString = double?.asString
                XCTAssertTrue(double?.type == .NumberType && isDouble && double?.asDouble == 0.08251977, "converted values failed check!")
                XCTAssertTrue(doubleAsString! == NSNumber(double: 0.08251977).stringValue, "converted values don't match!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testConversionAccessorsJSON() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_accessors.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {

                let int = json["intString"]
                XCTAssertTrue(int?.type == .StringType && int?.asInt == -1234, "converted values failed check!")
                XCTAssertTrue(int!.asString == NSNumber(long: -1234).stringValue, "converted values don't match!")

                let int32 = json["int32String"]
                XCTAssertTrue(int32?.type == .StringType && int32?.asInt32 == -2147483647, "converted values failed check!")
                XCTAssertTrue(int32!.asString == NSNumber(int: -2147483647).stringValue, "converted values don't match!")

                let int64 = json["int64String"]
                XCTAssertTrue(int64?.type == .StringType && int64?.asInt64 == -9223372036854775807, "converted values failed check!")
                XCTAssertTrue(int64!.asString == NSNumber(longLong: -9223372036854775807).stringValue, "converted values don't match!")

                let uint = json["uintString"]
                XCTAssertTrue(uint?.type == .StringType && uint?.asUInt == 1234, "converted values failed check!")
                XCTAssertTrue(uint!.asString == NSNumber(unsignedLong: 1234).stringValue, "converted values don't match!")

                let uint32 = json["uint32String"]
                XCTAssertTrue(uint32?.type == .StringType && uint32?.asUInt32 == 4294967295, "converted values failed check!")
                XCTAssertTrue(uint32!.asString == NSNumber(unsignedInt: 4294967295).stringValue, "converted values don't match!")

                let uint64 = json["uint64String"]
                XCTAssertTrue(uint64?.type == .StringType && uint64?.asUInt64 == 18446744073709551615, "converted values failed check!")
                XCTAssertTrue(uint64!.asString == NSNumber(unsignedLongLong: 18446744073709551615).stringValue, "converted values don't match!")
                
                let float = json["floatString"]
                XCTAssertTrue(float?.type == .StringType && float?.asFloat == 0.00000011920928955078125, "converted values failed check!")
                XCTAssertTrue(float!.asString == NSDecimalNumber(string: "0.00000011920928955078125").stringValue, "converted values don't match!")

                let double = json["doubleString"]
                XCTAssertTrue(double?.type == .StringType && double?.asDouble == 0.333333333333333314829616256247390992939, "converted values failed check!")
                XCTAssertTrue(double!.asString == NSDecimalNumber(string: "0.333333333333333314829616256247390992939").stringValue, "converted values don't match!")

            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testSubscript() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_array.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            let aName = json?[2]?["name"]?.asString
            XCTAssert(aName == "Dennis", "The name should be \"Dennis\"!")

            if let json = json {
                if let item = json[3] {
                    if let name = item["name"] {
                        XCTAssert(name.type == .NullType, "The name should be a null!")
                    }
                }
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testArrayAccessor() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_array.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                let array = json.asArray
                if let array = array {
                    let firstItem: NSDictionary = array[0] as! NSDictionary
                    let value: String = firstItem.valueForKey("name") as! String
                    XCTAssertTrue(value == "Bedevere", "We aren't getting an array back!")
                } else {
                    XCTAssertTrue(1 == 0, "We aren't getting an array back!")
                }
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }

    func testDictionaryAccessor() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_dictionary.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                let dict = json.asDictionary
                if let dict = dict {
                    let attrs: NSArray = dict["attrs"] as! NSArray
                    let uglyItem: NSString = attrs[1] as! NSString
                    XCTAssertTrue(uglyItem == "ugly", "We aren't getting the proper value back!")
                } else {
                    XCTAssertTrue(1 == 0, "We aren't getting an dictionary back!")
                }
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }
    
    func testJSONObjectToString() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_dictionary.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                let jsonString = json.asJSONString(pretty: true)
                println(jsonString!)
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }

    }

    func testDictionaryIterator() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_dictionary.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                var jsonDict = Dictionary<String, JSON>()

                for (key, value) in json {
                    jsonDict[key as! String] = value
                }

                let dirtIndex = jsonDict["dirtIndex"]
                XCTAssertTrue(dirtIndex?.asDouble == 3.14, "The items weren't iterated properly!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }
    
    func testArrayIterator() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_array.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            if let json = json {
                var jsonArray = Array<JSON>()

                for (index, value) in json {
                    jsonArray.append(value)
                }

                let dennisString = jsonArray[2]["name"]
                XCTAssertTrue(dennisString?.asString == "Dennis", "The items weren't iterated properly!")
            } else {
                XCTAssert(1 == 0, "We didn't get valid json input here, what gives?")
            }
        } else {
            XCTAssert(file != nil, "Something happened to the test file, call 911!")
        }
    }
    
}
