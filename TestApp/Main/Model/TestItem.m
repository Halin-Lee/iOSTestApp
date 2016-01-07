//
//  TestItem.m
//  TestApp
//
//  Created by Halin on 11/10/15.
//  Copyright (c) 2015 me.halin. All rights reserved.
//

#import "TestItem.h"

@implementation TestItem


+ (instancetype)testItemWithTestGroup:(NSString *)group name:(NSString *)name clazz:(Class)clazz{
    TestItem *item = [[TestItem alloc] init];
    item->_testGroup = group;
    item->_testName = name;
    item->_clazz = clazz;
    return item;
}

@end
