//
//  ObjectiveCToSwift.swift
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

import Foundation

@objc class ObjectiveCToSwift : NSObject {
    var swiftObj: ObjectiveCToSwift?
    var swiftString:String = ""
    
    override init(){
        self.swiftObj = nil;
    }
    
    func swiftMethod() -> ObjectiveCToSwift{
        let obj = ObjectiveCToSwift();
        obj.swiftObj = obj;
        obj.swiftString = "String";
        return obj;
    }
    
    static func test(){
    
        let obj = SwiftToObjectiveC().objectiveCMethod();

        print("Objective-C Obj in Swift Obj: \(obj) Param: \(obj.objectiveCObj) String: \(obj.objectiveCString)")
    }
}




