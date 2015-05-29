//
//  JSONModel.swift
//  THGJSON
//
//  Created by Brandon Sneed on 5/16/15.
//  Copyright (c) 2015 TheHolyGrail. All rights reserved.
//

import Foundation


public protocol JSONModel {
    init?(_ json: JSON?)
    func isValidModel() -> Bool
}

@objc(THGJSONModel)
public protocol THGJSONModel {
    init?(_ json: JSON?)
    func isValidModel() -> Bool
}
