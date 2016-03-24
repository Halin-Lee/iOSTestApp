//
//  SwiftToObjectiveC.m
//  TestApp
//
//  Created by Halin on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "SwiftToObjectiveC.h"
#import "TestApp-Swift.h"


@implementation SwiftToObjectiveC


- (SwiftToObjectiveC *)objectiveCMethod{
    SwiftToObjectiveC *obj = [[SwiftToObjectiveC alloc] init];
    obj.objectiveCObj = self;
    obj.objectiveCString = @"String";
    return obj;
}


+ (void)test{
    
    ObjectiveCToSwift *swiftObject = [[[ObjectiveCToSwift alloc] init] swiftMethod];
    NSLog(@"Swift Obj in Objective-C Obj: %@ Param: %@ String: %@",swiftObject,swiftObject.swiftObj,swiftObject.swiftString);
}

@end
