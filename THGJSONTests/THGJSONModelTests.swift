//
//  THGJSONModelTests.swift
//  THGJSON
//
//  Created by Brandon Sneed on 5/16/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import UIKit
import XCTest
import THGJSON

struct MyNonModel {
    let mystring: String?
}

struct MySubModel: JSONModel {
    let mystring: String?

    init(_ json: JSON?) {
        mystring = json?["mystring"]?.asString()
    }

    func isValidModel() -> Bool {
        return true
    }
}

struct MyModel: JSONModel {
    let mystring: String
    let myuint: UInt?
    let mynumber: NSNumber?
    let myarray1: Array<AnyObject>?
    let myarray2: [String]?
    let myarray3: NSArray?
    let mydict: Dictionary<String, AnyObject>?
    let mynonmodel: MyNonModel?
    let mysubmodel: MySubModel?
    let mysubmodelarray: Array<MySubModel>?
    let mydictionaryModels: Dictionary<String, MySubModel>?

    init?(_ json: JSON?) {
        // basics
        mystring = json!["mystring"]!.asString()!
        myuint = json?["myuint"]?.asUInt()
        mynumber = json?["mynumber"]?.asDecimalNumber()
        myarray1 = json?["myarray1"]?.asArray()
        myarray2 = json?["myarray2"]?.asArray() as? [String]
        myarray3 = json?["myarray2"]?.asArray()
        mydict = json?["myobject"]?.asDictionary()

        // a non-model type
        mynonmodel = MyNonModel(mystring: json?["myobject"]?["mystring"]?.asString())

        // a model type
        mysubmodel = MySubModel(json?["myobject"])

        // an array of MySubModel's
        mysubmodelarray = json?["myobjectarray"]?.asArray()

        // a dictionary with MySubModel values
        mydictionaryModels = json?["mydictionary"]?.asDictionary()

        if !isValidModel() {
            return nil
        }
    }

    func isValidModel() -> Bool {
        if myuint != nil && mysubmodelarray?.count == 4 {
            return true
        }
        return false
    }
}

class THGJSONModelTests: XCTestCase {

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

    func testBasicMapping() {
        let file: String? = NSBundle(forClass: THGJSONTests.self).pathForResource("jsontest_models.json", ofType: nil)
        if let file = file {
            let data = NSData(contentsOfFile: file)

            let json = JSON(data: data)

            let object = MyModel(json)
            println(object?.mysubmodel?.mystring)
        }
    }

}
