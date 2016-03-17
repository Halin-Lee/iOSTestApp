//
//  SwiftDemo.m
//  TestApp
//
//  Created by 17track on 3/17/16.
//  Copyright © 2016 me.halin. All rights reserved.
//

#import "SwiftDemo.h"
#import "SwiftToObjectiveC.h"
#import "TestApp-Swift.h"

@implementation SwiftDemo


+ (void)test{
    [SwiftToObjectiveC test];
    [ObjectiveCToSwift test];
}

@end
